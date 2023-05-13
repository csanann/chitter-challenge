#file: spec/user_repository_spec.rb

require 'spec_helper'
require 'lib/user_repository'

#require_relative 'user_repository'
require 'user'
require 'bcrypt'

RSpec.describe UserRepository do
  def reset_users_table
    seed_sql = File.read('ables_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
    #@user_repo = UserRepository.new
  end

  it 'returns all users' do
    repo = UserRepository.new
    users = repo.all
    
    expect(users.length).to eq (2)
    expect(users[0].id).to eq (1)
    expect(users[0].name).to eq ('ken')
  end

#  context '#log_in' do
#    it 'logs in a valid user' do
#      repo = UserRepository.new
#      repo.log_in('hothot@hotmail.com', 'dada123')
#    end
#  end

  context '#create' do
    it 'creates a new user' do
      repo = UserRepository.new
  
      created_user = User.new
      created_user.name = 'jan'
      created_user.username = 'jan8989'
      created_user.email = 'janjan@hotmail.com'
      created_user.password = 'jaja123'
      repo.create(created_user)
      
      users = repo.all
      last_user = users.last
  
      expect(users.length).to eq(3)
      expect(last_user.name).to eq('jan')
      expect(last_user.email).to eq('janjan@hotmail.com')
      expect(last_user.username).to eq('jan8989')
      expect(BCrypt::Password.new(last_user.password)).to eq('jaja123')
    end
  end
  
  context '#find_by_email' do
    it 'returns the user with the given email' do
      repo = UserRepository.new
      user = repo.find_by_email('hothot@hotmail.com')
      expect(user.name).to eq('ken')
      expect(user.password).to eq('dada123')
    end

    it 'returns nil if user input different email' do
      repo = UserRepository.new
      user = repo.find_by_email('ahaha@ahmail.com')
      expect(user).to be_nil
    end
  end
end
