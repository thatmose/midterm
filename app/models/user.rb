class User < ActiveRecord::Base
  has_many :books
  has_many :posts
  has_many :borrowed_books
end