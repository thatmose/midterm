require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :books
  has_many :posts
  has_many :borrowed_books

  validates :email, presence: true

  # validates :username, uniqueness: true
  #Wasn't showing the flash message

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end