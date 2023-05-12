#file: spec/peep_repository_spec.rb

#require 'peep'
require_relative '../app/models/peep_repository'


RSpec.describe PeepRepository do
  let(:database_connection) { instance_double(PG::Connection)}
  let(:peep_repository) { PeepRepository.new(database_connection)}

  def reset_peeps_table
    seed_sql = File.read('data/tables_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter'})
    connection.exec(seed_sql)
  end
      
  before(:each)do
    reset_peeps_table
  end

#  context '#all' do
#   it 'returns a list of users' do
#      repo = PeepRepository.new
#      peeps = repo.all
#
#      expect(peeps.length).to eq(2)
#      expect(peeps[0].id).to eq(1).to_i
#      expect(peeps[0].message).to eq('My name is Ken YoohaaaYoo.')
#    end
#  end

  describe '#create' do
    it 'creates a new peep' do
      peep = Peep.new(message: 'What a lovely day!', timestamp: Time.now, user_id: 3)

      expect(database_connection).to receive(:exec_params).with('INSERT INTO peeps (message, timestamp, user_id) VALUES ($1, $2, $3);',
      [peep.message, peep.timestamp, peep.user_id])
      peep_repository.create(peep)
    end
  end

  describe '#find_by_id' do
    it 'finds a peep by id' do
      result = instance_double(PG::Result)
      expect(database_connection).to receive(:exec_params).with('SELECT * FROM peeps WHERE id = $1;', [1]).and_return(result)
      expect(result).to receive(:ntuples).and_return(1)
      expect(result).to receive(:[]).with(0).and_return({ 'id' => '1', 'message' => 'My name is Ken YoohaaaYoo.', 'timestamp' => Time.now.to_s, 'user_id' => '1' })
      peep = peep_repository.find_by_id(1)
      expect(peep.id).to eq(1)
      expect(peep.message).to eq('My name is Ken YoohaaaYoo.')
      expect(peep.user_id).to eq(1)
    end
  end

  describe '#delete_by_id' do
    it 'deletes a peep by id' do
      expect(database_connection).to receive(:exec_params).with('DELETE FROM peeps WHERE id = $1;', [1])
      peep_repository.delete_by_id(1)
    end
  end
end
