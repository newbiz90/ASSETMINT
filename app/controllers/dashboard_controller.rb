class DashboardController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def index
    @transaction = Transaction.new
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @alltickers = Ticker.all
    @usertickers = UserTicker.includes(:ticker).all
    @txn_count = 0

    @newstickers = UserTicker.includes(:ticker).sample(5)

    if params[:refresh_news]
      PolygonApiClient.get_news(@newstickers.sample(5).map(&:ticker).map(&:name))
    end

    @news_snippets = NewsSnippet.where(
      ticker: @usertickers.map(&:ticker)
    ).order(created_at: :desc).limit(5)
  end
end
