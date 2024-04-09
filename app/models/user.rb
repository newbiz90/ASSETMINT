class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Subscriptions as a subscribable entity
  has_many :subscribers, as: :subscribable, class_name: 'Subscription'

  has_many :subscriptions

  # Follower associations
  has_many :follower_subscriptions, foreign_key: :subscribable_id, class_name: "Subscription"
  has_many :followers, through: :follower_subscriptions, source: :user

  # Following associations
  has_many :following_subscriptions, foreign_key: :user_id, class_name: "Subscription"
  has_many :following, through: :following_subscriptions, source: :subscribable, source_type: 'User'
  has_many :user_tickers
  has_many :tickers, through: :user_tickers

  has_many :transactions, through: :user_tickers
end
