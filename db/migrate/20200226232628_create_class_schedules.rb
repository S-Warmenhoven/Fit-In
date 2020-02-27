class CreateClassSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :class_schedules do |t|
      t.string :title
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
