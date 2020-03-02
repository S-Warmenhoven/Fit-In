class FoodItem < ApplicationRecord
    has_many :user_meals
    belongs_to :section

    # def self.search(search)
    #     where("name ILIKE ?", "%#{search}%" )
    # end

    scope :search, lambda { |query|
    where("name ILIKE '%#{query}%' OR description ILIKE '%#{query}%'")
      .order(
        # Order first by products whose titles that contain the `query`
        "name ILIKE '%#{query}%' DESC",
        # Then, if a product's title and description contain the `query`,
        # put products whose descriptions also contain the `query` later in results
        "description ILIKE '%#{query}%' ASC"
      )
    }

end
