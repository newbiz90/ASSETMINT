class Ticker < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true } # Perform prefix search
    }

  has_many :user_tickers
  has_many :users, through: :user_tickers
  has_many :news_snippets

  # Add any validations or methods specific to the Ticker model here
  validates :name, presence: true, uniqueness: true
end
