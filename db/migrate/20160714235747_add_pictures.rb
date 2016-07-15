class AddPictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :book
      t.string :url
      t.timestamp
    end
  end
end
