class SocialEvent < ApplicationRecord
    #Association
    belongs_to :user

    #Validations
    validates :description, presence: true, length: {minimum: 3}
end
