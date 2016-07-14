class AddUsersTable < ActiveRecord::Migration
  def change 
    create_table :users do |t|
      t.string :username, presence: true
      t.string :email, presence: true
      t.integer :books_contributed, default: 0
      t.timestamps
    end
  end
end
