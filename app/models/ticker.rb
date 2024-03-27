class Ticker < ApplicationRecord
  has_many :user_tickers
  has_many :users, through: :user_tickers
  has_many :news_snippets

  # Add any validations or methods specific to the Ticker model here
  validates :name, presence: true, uniqueness: true
end
