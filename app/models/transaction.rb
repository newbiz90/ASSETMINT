class Transaction < ApplicationRecord
  belongs_to :user_ticker

  delegate :user, to: :user_ticker

  # Add any validations or methods specific to the Transaction model here
  validates :flow, :txndate, :txnprice, :qty, presence: true

  def self.filtered_transactions(ticker_name)
    if ticker_name.present?
      joins(user_ticker: :ticker).where("tickers.name = ?", ticker_name)
    else
      all
    end
  end
end
