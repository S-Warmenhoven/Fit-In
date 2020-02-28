class CreateUserMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :user_meals do |t|
      t.references :food_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :price
      t.integer :meal_number
      t.text :comment

      t.timestamps
    end
  end
end
