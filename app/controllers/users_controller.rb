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

  def follow
    followed_user = User.find(params[:user_id])
    current_user.follow(followed_user)
    flash[:notice] = 'You are now following this user.'

    respond_to do |format|
      format.html { redirect_to user_path(followed_user) } # Redirect for HTML request
      format.json { render json: { success: true } } # Response for AJAX request
    end
  end

  def unfollow
    followed_user = User.find(params[:user_id])
    subscription = current_user.subscriptions.find_by(followed_user: followed_user)
    if subscription
      subscription.destroy
      flash[:notice] = 'You have unfollowed this user.'
    else
      flash[:alert] = 'You are not following this user.'
    end
    redirect_to user_path(followed_user)
  end
end
