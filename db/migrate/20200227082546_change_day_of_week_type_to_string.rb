class ChangeDayOfWeekTypeToString < ActiveRecord::Migration[6.0]
  
  def up
    change_column :class_schedules, :day_of_week, :string
  end

  def down
    change_column :class_schedules, :day_of_week, :integer
  end

end
