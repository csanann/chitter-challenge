# file: lib/users_controller.rb

require 'sinatra/base'
require 'user'

class UsersController < Sinatra::Base
  #set :views, 'lib/views'

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    User.create({
      name: params[:name],
      username: params[:username],
      email: params[:email],
      password: params[:password]
    })
    session[:user_id] = User.find_by_username(params[:username]).id
    redirect '/peeps'
  end


  run! if app_file == $0
end
