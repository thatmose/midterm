class AddBorrowedBooks < ActiveRecord::Migration
  def change
    create_table :borrowed_books do |t|
      t.references :user
      t.references :book
      t.timestamps
    end
  end
end
