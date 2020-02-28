class CreateFoodItems < ActiveRecord::Migration[6.0]
  def change
    create_table :food_items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :meal_number
      t.string :image_url
      t.references :section, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
