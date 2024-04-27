class Transaction < ApplicationRecord
  belongs_to :user_ticker
  belongs_to :user

  # Add any validations or methods specific to the Transaction model here
  validates :flow, :txndate, :txnprice, :qty, presence: true

  default_scope -> { order(txndate: :desc) }

  before_save :set_txnamt

  def self.filtered_transactions(ticker_name)
    if ticker_name.present?
      joins(user_ticker: :ticker).where("tickers.name = ?", ticker_name)
    else
      all
    end
  end

  def fetch_current_price
    # Implement API call or another method to fetch real-time price
    # Placeholder: Return the last known price for simplicity
    0
  end

  def calculate_pl
    # Simple P/L calculation: (current price - entry price) * quantity
    (fetch_current_price - txnprice) * qty
  end

  private

  def set_txnamt
    self.txnamt = txnprice * qty
  end
end
