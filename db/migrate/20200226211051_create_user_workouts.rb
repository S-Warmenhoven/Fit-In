class CreateUserWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_workouts do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
