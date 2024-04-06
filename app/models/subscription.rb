class Subscription < ApplicationRecord
  belongs_to :subscribable, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :user_ticker, optional: true
end
