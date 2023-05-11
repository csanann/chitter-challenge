#file: app/models/user.rb

class User < ApplicationRecord
    has_many :peeps
  
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :username, presence: true, uniqueness: true
  
    def authenticate(password)
      self.password == password
    end
  end
  