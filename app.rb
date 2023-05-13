# file: lib.users_controller.rb

require 'sinatra/base'
require 'sinatra/reloader'
require 'user'
require 'peep'
require 'spec/database_connection'


DatabaseConnection.connect('chitter')


class Main < Sinatra::Base
  enable :sessions
  register Sinatra::Reloader


  get '/' do
    @peeps = Peep.all
    erb :'peeps/index'
  end


  get '/users' do
    @users = User.all
    erb :'users/index'
  end


  get '/users/new' do
    erb :'users/new'
  end


  post '/users' do
    User.create(params[:name], params[:username], params[:email], params[:password])
    session[:user_id] = User.find_by_username(params[:username]).id
    redirect '/peeps'
  end


  get '/peeps/new' do
    erb :'peeps/new'
  end


  post '/peeps' do
    Peep.create(content: params[:content], user_id: session[:user_id])
    redirect '/peeps'
  end


  get '/sessions/new' do
    erb :'sessions/new'
  end


  post '/sessions' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/peeps'
    else
      erb :'sessions/new'
    end
  end


  post '/sessions/destroy' do
    session.clear
    redirect '/sessions/new'
  end


  run! if app_file == $0
end
