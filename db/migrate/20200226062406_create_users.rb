class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      t.string :program
      t.integer :meals
      t.decimal :food_account
      t.string :role
      t.string :password_digest

      t.timestamps
    end
  end
end
