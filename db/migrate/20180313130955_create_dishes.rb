class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.string :image
      t.float :price

      t.integer :restaurant_id

      t.timestamps
    end
  end
end
