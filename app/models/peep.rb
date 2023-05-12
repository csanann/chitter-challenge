#file: app/models/peep.rb

class Peep 
  attr_accessor :id, :message, :timestamp,:user_id

  def initialize(id: nil, message:,timestamp:, user_id:)
    @id = id
    @message = message
    @timestamp = timestamp
    @user_id = user_id
  end
end