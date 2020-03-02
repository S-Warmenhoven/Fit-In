class Workout < ApplicationRecord
  # Assiociations
  has_many :users
  has_many :users, through: :user_workouts
  has_many :user_workouts, dependent: :destroy
  belongs_to :user
  
end
