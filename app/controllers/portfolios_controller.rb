class PortfoliosController < ApplicationController
  def show
    @user = User.find(params[:id])

    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all

    if params.dig(:search, :ticker_name).present?
      ticker = Ticker.find_by(name: params[:search][:ticker_name])
      filtered_user_ticker = UserTicker.where(ticker:, user: @user)
      @usertxns = Transaction.where(user_ticker: filtered_user_ticker)
    else
      @usertxns = @user.transactions
    end
  end

  def me
    redirect_to portfolio_path(current_user)
  end
end
