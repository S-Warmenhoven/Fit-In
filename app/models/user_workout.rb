class UserWorkout < ApplicationRecord
  #Association
  belongs_to :workout
  belongs_to :user

  #Validations
  #validates :start_time, :end_time, presence: true  
  # validate :end_time_after_start_time
  #validate :available

  # The following will ensure that the workout_id / user_id
  # combination is unique.
  # Said in plain english, this is needed to make sure that 
  # a user can only like a workout once. 
  validates(
    :workout_id, 
    uniqueness: {
      scope: :user_id,
      message: "has already been booked"      
    }
  )

  #AASM Gem functions for state of reserving workout
  include AASM

  aasm do
    state :reserved, initial: true
    state :rejected, :approved

    event :approving do
      transitions from: :reserved, to: :approved
    end

    event :rejecting do
      after do
        self.destroy
      end
      transitions from: :reserved, to: :rejected
    end

  end

  private

  def end_time_after_start_time    
    return if end_time.blank? || start_time.blank?
      if end_time < start_time      
        errors.add(:end_time, "Your end time must be after the start time.")    
      end 
  end

  def available
    conflicts = UserWorkout.where(workout_id: workout_id)
      .where("start_time < ? AND end_time > ?", start_time, start_time)
      .or(UserWorkout.where("start_time < ? AND end_time > ?", end_time, end_time))
      .or(UserWorkout.where("start_time > ? AND end_time < ?", start_time, end_time))

    if conflicts.exists?
      errors.add(:start_time, "The time you have selected is unavailable. Please select another time slot.")
    end

  end
  
end
