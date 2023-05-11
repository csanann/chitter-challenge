#file: app.rb
# file: app.rb

require_relative 'lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])



class Application < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
    end


end

