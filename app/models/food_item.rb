class FoodItem < ApplicationRecord
    has_many :user_meals
    belongs_to :section
end
