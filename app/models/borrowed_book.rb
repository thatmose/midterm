class BorrowedBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book #Had to change this. Can't have has_one on both sides. One has to belong to the other. The foreign key is in the BorrowedBook so it belongs to book
end