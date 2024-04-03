class Subscription < ApplicationRecord
  belongs_to :subscribable, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :user_ticker, optional: true

  belongs_to :subscriber, class_name: "User"
  belongs_to :followed_user, class_name: "User"
end
