class Post < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :review, presence: true
  
end