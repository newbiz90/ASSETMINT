class UserTicker < ApplicationRecord
  belongs_to :user
  belongs_to :ticker
  has_many :subscribers, as: :subscribable, class_name: 'Subscription'

  has_many :transactions
  # Add any validations or methods specific to the UserTicker model here
end
