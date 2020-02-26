class CreateSocialEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :social_events do |t|
      t.string :title
      t.text :description
      t.string :when
      t.string :image_url

      t.timestamps
    end
  end
end
