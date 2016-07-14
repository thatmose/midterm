class AddPosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :book
      t.integer :rating
      t.text :review
      t.timestamps
    end
  end
end
