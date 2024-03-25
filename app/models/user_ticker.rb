class UserTicker < ApplicationRecord
  belongs_to :user
  belongs_to :ticker

  # Add any validations or methods specific to the UserTicker model here
end
