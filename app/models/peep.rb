#file: app/models/peep.rb

class Peep < ApplicationRecord
    belongs_to :user
  
    validates :message, presence: true
  
    def username
      user.username
    end
  
    def self.public_stream
      order(timestamp: :desc)
    end
  end