class UserMeal < ApplicationRecord
  belongs_to :food_item
  belongs_to :user

  scope :search, lambda { |query|
    where("created_at LIKE '%#{query}%'")
  }

end
