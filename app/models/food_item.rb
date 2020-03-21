class FoodItem < ApplicationRecord
  #Assiociations
  has_many :user_meals
  belongs_to :section

  #Custom methods
  scope :search, lambda { |query|
  where("name ILIKE '%#{query}%' OR description ILIKE '%#{query}%'")
    .order(
      # Order first by food item whose name contains the `query`
      "name ILIKE '%#{query}%' DESC",
      # Then, if a food item's name and description contain the `query`,
      # put food items whose descriptions also contain the `query` later in results
      "description ILIKE '%#{query}%' ASC"
    )
  }

end
