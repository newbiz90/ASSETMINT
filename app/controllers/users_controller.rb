class UsersController < ApplicationController
  before_action :set_user, only: [:show, :gen_news_snp]

  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @usertxns = Transaction.where(user_ticker: @user.user_tickers)
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all
    @user_news_snippets = NewsSnippet.where(ticker: @user.tickers).order(created_at: :desc)
  end

  def gen_news_snp
    @user.user_tickers.each do |user_ticker|
      # Fetch news for each ticker
      news_items = NewsFetcher.fetch_news_for_ticker(user_ticker.ticker.name)

      news_items.each do |news_item|
        # Process and save each news item
        news_snippet = NewsSnippet.find_or_initialize_by(ticker: user_ticker.ticker)
        news_snippet.content = news_item[:content]
        news_snippet.save
      end
    end
    # Redirect once all tickers have been processed
    redirect_to user_path(@user), notice: 'News snippets generated successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
