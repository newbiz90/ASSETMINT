class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @usertxns = Transaction.where(user_ticker: @user.user_tickers)
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all
  end
end
