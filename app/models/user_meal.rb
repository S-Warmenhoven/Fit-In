class UserMeal < ApplicationRecord
  belongs_to :food_item
  belongs_to :user

  
end
