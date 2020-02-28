class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name, index: true
      
      t.timestamps
    end
  end
end
