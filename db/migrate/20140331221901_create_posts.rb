class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :city
      t.string :name
      t.string :category
      t.string :description
      t.string :price

      t.timestamps
    end
  end
end
