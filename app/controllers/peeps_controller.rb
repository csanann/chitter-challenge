#file: app/controllers/peeps_controller.rb

#Function: to responds to HTTP requests.
#it reads data from the models and pass the data to a view to be rendered as HTML

require 'sinatra/base'
require_relative '../models/peep_repository'

class PeepsController < Sinatra::Base
  set :views, 'app/views'
#action1: responds to HTTP GET requests at the '/peeps'URL
#fetch the peeps data from DB and renders the 'index.erb'view
  get '/peeps' do
    @peeps = PeepRepository.new.all
    erb :index
  end
#action2: responds to HTTP requests at the '/peeps' URL
#creates a new peep using the data in the request, saves it into DB and redirects the user to the '/peeps'URL
  post '/peeps' do
    peep = Peep.new(params[:peep])
    PeepRepository.new.create(peep)
    redirect '/peeps'
  end
end
