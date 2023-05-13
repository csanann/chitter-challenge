# file: spec/main_spec.rb
$LOAD_PATH.unshift(File.expand_path(__dir__))
require 'rack/test'
require '/Users/chayadasansiriwong/Desktop/csanann/Projects/chitter-challenge/app.rb'

describe 'App Application' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it 'directs to the index page when visiting the root path' do
    get '/'
    puts last_response.body
    expect(last_response).t0 be_redirect
    follow_redirect!
    expect(last_request.path).to eq('/index')
  end

  #To add more tests here to test the behavior of your entire application.
end
