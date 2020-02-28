class Workout < ApplicationRecord
  # Assiociations
  belongs_to :user
  has_many :users
  has_many :trainees, through: :user_workouts, source: :user, dependent: :destroy

end
