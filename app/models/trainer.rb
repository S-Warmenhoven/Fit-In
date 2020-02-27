class Trainer < ApplicationRecord
    #Association
    belongs_to :user

    #Validations
    validates :description, presence: true, length: {minimum: 3}
    validates :name, presence: true
end
