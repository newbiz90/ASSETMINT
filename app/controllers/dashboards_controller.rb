class DashboardsController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def show
    @transaction = Transaction.new
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @alltickers = Ticker.all
    @usertickers = UserTicker.includes(:ticker).all
    @txn_count = 0

    @newstickers = UserTicker.includes(:ticker).sample(5)

    if params[:refresh_news] # refresh_news=true
      PolygonApiClient.get_news(@newstickers.map(&:ticker).map(&:name))
    end

    @news_snippets = NewsSnippet.where(
      ticker: @usertickers.map(&:ticker)
    ).order(created_at: :desc).limit(5)
  end
end
