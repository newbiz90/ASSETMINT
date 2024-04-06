class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Subscriptions as a subscribable entity
  has_many :subscriptions, as: :subscribable

  # Follower associations
  has_many :follower_subscriptions, foreign_key: :subscribable_id, class_name: "Subscription"
  has_many :followers, through: :follower_subscriptions, source: :user

  # Following associations
  has_many :following_subscriptions, foreign_key: :user_id, class_name: "Subscription"
  has_many :following, through: :following_subscriptions, source: :subscribable, source_type: 'User'
  has_many :user_tickers
  has_many :tickers, through: :user_tickers


  def generate_news_for_my_tickers
    self.user_tickers.each do |user_ticker|
      # Fetch news for a given ticker symbol.
      # Use a static method on a NewsFetcher service.
      news_items = NewsFetcher.fetch_news_for_ticker(user_ticker.ticker.name)

      # Assuming fetch_news_for_ticker returns an array of news items
      news_items.each do |news_item|
        # Create or update the news snippet for the ticker
        news_snippet = NewsSnippet.find_or_initialize_by(ticker: user_ticker.ticker)
        news_snippet.content = news_item.summary
        news_snippet.save
      end
    end
  end
end
