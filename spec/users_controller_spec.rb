#file: spec/users_controller_spec.rb

require 'rack/test'
require 'rspec'
require_relative 'users_controller'

describe UsersController do
  include Rack::Test::Methods

  def app
    App.new
  end

  context 'GET /users' do
    it 'displays a list of users' do
      get '/users'
      expect(last_response).to be_ok
    end
  end

  context 'GET /users/new' do
    it 'displays a form for creating a new user' do
      get '/users/new'
      expect(last_response).to be_ok
    end
  end

  context 'POST /users' do
    it 'creates a new user' do
      post '/users', { user: { name: 'John', email: 'john@example.com', password: 'password123' } }
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/users')
    end
  end
end
