class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions, as: :subscribable

  has_many :followers_subscriptions, foreign_key: :subscribable_id, class_name: "Subscription"
  has_many :followers, through: :followers_subscriptions, source: :user

  has_many :following_subscriptions, foreign_key: :user_id, class_name: "Subscription"
  has_many :following, through: :following_subscriptions, source: :subscribable, source_type: 'User'
end
