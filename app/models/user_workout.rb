class UserWorkout < ApplicationRecord
  #Associations
  belongs_to :workout
  belongs_to :user

  #Validations
  validate :available

  # The following will ensure that the workout_id / user_id
  # combination is unique. 
  validates(
    :workout_id, 
    uniqueness: {
      scope: :user_id,
      message: "Has already been booked"      
    }
  )

  #AASM Gem functions for state of reserving workout
  #Thus far reserving function is implemented; however,
  #it would depend on the organization if they would like to
  #implement the approve/reject functions
  #The App is currently only allowing trainers (and admin) 
  #to delete bookings through deleteing workouts
  
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

    if conflicts.exists?
      errors.add(:start_time, "The time you have selected is unavailable. Please select another time slot.")
    end

  end
  
end
