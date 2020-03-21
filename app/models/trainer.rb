class Trainer < ApplicationRecord
    #Associations
    belongs_to :user

    #Validations
    validates :description, presence: true, length: {minimum: 3}
    validates :name, presence: true

end
