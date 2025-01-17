class Workout < ApplicationRecord
  #Assiociations
  has_many :users
  has_many :users, through: :user_workouts
  has_many :user_workouts, dependent: :destroy
  belongs_to :user

  #Validations
  validates :start_time, :end_time, presence: true  
  validate :end_time_after_start_time
  validate :available
  
  validates(
    :start_time, 
    uniqueness: {
      scope: :user_id,
      message: "has already been used"      
    }
  )
  
  # Custom methods
  scope :search, lambda { |query|
    where("user ILIKE '%#{query}%'")
    }

  private

  def end_time_after_start_time    
    return if end_time.blank? || start_time.blank?
      if end_time < start_time      
        errors.add(:end_time, "must be after the start time.")    
      end 
  end

  def available
    conflicts = Workout.where(user_id: user_id)
      .where("start_time < ? AND end_time > ?", start_time, start_time)
      .or(Workout.where("start_time < ? AND end_time > ?", end_time, end_time))
      .or(Workout.where("start_time > ? AND end_time < ?", start_time, end_time))
    if conflicts.exists?
      errors.add(:start_time, "The time you have selected is unavailable. Please select another time slot.")
    end

  end

end
