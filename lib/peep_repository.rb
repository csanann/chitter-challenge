#file: lib/peep_repository.rb
require 'peep'


=begin
class PeepRepository
  def all
    peeps = []
    sql = 'SELECT id, message, timestamp, user_id FROM peeps;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      peeps << create_peep(record)
    end
    return peeps
  end

  def create(peep)
    sql = 'INSERT INTO peeps (message, timestamp, user_id) VALUES ($1, $2, $3);'
    result_set = DatabaseConnection.exec_params(sql, [peep.message, peep.timestamp, peep.user_id])
    return nil
  end

  def find_by_id(id)
    sql = 'SELECT peeps.id, message, timestamp, users.id as user_id, users.name, users.username
    FROM peeps
    JOIN users ON users.id = peeps.user_id
    WHERE peeps.id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)
  
    return create_peep(result[0])
  end
  
  private

  def create_peep(record)
    peep = Peep.new
    
    peep.id = record['id'].to_i
    peep.message = record['message']
    peep.timestamp = record['timestamp']
    peep.user_id = record['user_id'].to_i
    
    return peep
  end
end
=end
class PeepRepository

  def initialize(database_connection)
    @database_connection = database_connection
  end


  def create(peep)
    sql = 'INSERT INTO peeps (message, timestamp, user_id) VALUES ($1, $2, $3);'
    params = [peep.message, peep.timestamp, peep.user_id]
    @database_connection.exec_params(sql, params)
    return nil
  end  


  def find_by_id(id)
    sql = 'SELECT * FROM peeps WHERE id = $1;'
    params = [id]
    result = @database_connection.exec_params(sql, params)
    return nil if result.ntuples.zero?
    return create_peep(result[0])
  end


  def delete_by_id(id)
    sql = 'DELETE FROM peeps WHERE id = $1;'
    params = [id]
    @database_connection.exec_params(sql, params)
  end


  private


  def create_peep(record)
    Peep.new(id: record['id'].to_i, message: record['message'], timestamp: record['timestamp'], user_id: record['user_id'].to_i)
  end
end
