#file: app/models/user_repository.rb

require_relative 'user'
require 'bcrypt'


class UserRepository
 
  def create(user)
    encrypted_password = BCrypt::Password.create(user.password)
 
    sql = 'INSERT INTO users (email, password, name, username) VALUES($1, $2, $3, $4);'
    params = [user.email, encrypted_password, user.name, user.username]
    result = DatabaseConnection.exec_params(sql, params)

    return nil
  end
 

  def all
    users = []

    sql = 'SELECT id, name, username, password, email FROM users;'
    result_set  = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      users << create_user(record)
    end
    return users
  end

  def find_by_email(email)
    sql = 'SELECT id, email, password, name, username FROM users WHERE email = $1;'
    params = [email]

    result = DatabaseConnection.exec_params(sql, params)
   
    return nil if result.ntuples.zero?

    return create_user(result[0])
  end

##  def log_in(email, submitted_password)
#    user = find_by_email(email)
#    return nil if user.nil?
  
#    stored_pasword = BCrypt::Password.new(user.password)
    
#    if stored_password == submitted_password
#      return true
#    else
#      return false
#    end    
#  end

  private

  def create_user(record)
    user = User.new
    user.id = record['id'].to_i
    user.email = record['email']
    user.password = record['password']
    user.name = record['name']
    user.username = record['username']
    
    return user
  end
end
