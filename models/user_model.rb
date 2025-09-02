require 'sinatra/activerecord'
require 'bcrypt'
require 'securerandom'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3:db/development.sqlite3')

class User < ActiveRecord::Base
  has_many :notes, dependent: :destroy
  has_secure_password

  # generate a random salt for encryption when a new user is created
  before_create :generate_salt

  private

  def generate_salt
    self.salt = SecureRandom.hex(16) # 32-character hex string
  end
end
