class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @usertxns = Transaction.where(user_ticker: @user.user_tickers)
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all
    # raise
  end

  def follow
    followed_user = User.find(params[:user_id])
    current_user.follow(followed_user)
    respond_to do |format|
      format.html { redirect_to user_path(followed_user), notice: 'You are now following this user.' }
      format.json { render json: { success: true } }
    end
  end

  def unfollow
    followed_user = User.find(params[:user_id])
    current_user.unfollow(followed_user)
    respond_to do |format|
      format.html { redirect_to user_path(followed_user), notice: 'You have unfollowed this user.' }
      format.json { render json: { success: true } }
    end
  end
end
