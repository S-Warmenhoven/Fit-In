class UserWorkout < ApplicationRecord
  #Association
  belongs_to :workout
  belongs_to :user

  # Each user_workout can only be applied to a workout once
  # validates :user_workout_id, uniqueness: { scope: :workout_id }
  
end
