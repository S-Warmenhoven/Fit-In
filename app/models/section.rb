class Section < ApplicationRecord
    #Assiociations
    has_many :food_items, dependent: :destroy

    #Validations
    validates :name, presence: true, uniqueness: {case_sensitive: false}
    

    #Custom methods
    def self.generate_defaults
        %w(Breakfast Lunch Dinner Drinks).each do |name|
            Section.find_or_create_by(name: name)
        end
    end
    
end
