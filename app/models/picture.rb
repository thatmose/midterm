class Picture < ActiveRecord::Base
  belongs_to :book

  validates :url, presence: true
  
end