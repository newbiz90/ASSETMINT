class Transaction < ApplicationRecord
  belongs_to :user_ticker, foreign_key: "user_tickers_id"

  # Add any validations or methods specific to the Transaction model here
  validates :flow, :txndate, :txnprice, :qty, presence: true
end
