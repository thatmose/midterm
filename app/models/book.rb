class Book < ActiveRecord::Base
	belongs_to :user
  has_many :posts
  has_many :pictures
  has_one :borrowed_book
end