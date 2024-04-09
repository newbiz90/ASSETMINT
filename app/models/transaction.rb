class Transaction < ApplicationRecord
  belongs_to :user_ticker

  delegate :user, to: :user_ticker

  # Add any validations or methods specific to the Transaction model here
  validates :flow, :txndate, :txnprice, :qty, presence: true
end
