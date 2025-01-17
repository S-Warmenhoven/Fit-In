class User < ApplicationRecord
    #Associations

    #As trainee
    has_many :user_workouts, dependent: :destroy
    has_many :booked_workouts, through: :user_workouts, source: :workout
    
    #As trainer
    has_many :workouts, through: :user_workouts, dependent: :destroy

    #As admin
    has_many :social_events, dependent: :nullify
    has_many :class_schedules, dependent: :nullify
    has_many :trainers, dependent: :nullify

    # before_save :capitalize_name
    before_validation :set_default_role
    before_validation :set_default_meals
    before_validation :set_default_food_account

    #Validations
    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    has_secure_password

    validates :first_name, presence: true
    validates :last_name, presence: true

    validates :meals, numericality: {greater_than_or_equal_to: 0}

    def full_name
        "#{first_name} #{last_name}"
    end

    private

    def capitalize_name
        self.first_name.capitalize!
        self.last_name.capitalize!
    end

    def set_default_role
        self.role ||= "guest"
    end

    def set_default_meals
        self.meals ||= 0
    end

    def set_default_food_account
        self.food_account ||= 0.00
    end

end
