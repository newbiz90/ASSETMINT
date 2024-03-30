class UserTicker < ApplicationRecord
  belongs_to :user
  belongs_to :ticker
  has_many :subscriptions, as: :subscriber
  has_many :transcations, foreign_key: 'user_tickers_id'
  # Add any validations or methods specific to the UserTicker model here
end
