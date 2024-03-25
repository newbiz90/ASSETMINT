class Transaction < ApplicationRecord
  belongs_to :user_ticker

  # Add any validations or methods specific to the Transaction model here
end
