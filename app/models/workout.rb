class Workout < ApplicationRecord
  # Assiociations
  has_many :users
  has_many :users, through: :user_workouts
  belongs_to :user
  
end
