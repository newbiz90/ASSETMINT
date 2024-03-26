class UserTicker < ApplicationRecord
  belongs_to :user
  belongs_to :ticker
  has_many :subscriptions, as: :subscriber
  # Add any validations or methods specific to the UserTicker model here
end
