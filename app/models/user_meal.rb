class UserMeal < ApplicationRecord
  #Assiociations
  belongs_to :food_item
  belongs_to :user

  #Custom methods
  scope :search, lambda { |query|
    where("created_at LIKE '%#{query}%'")
  }

end
