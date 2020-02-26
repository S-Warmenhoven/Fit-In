class CreateTrainers < ActiveRecord::Migration[6.0]
  def change
    create_table :trainers do |t|
      t.string :image_url
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
