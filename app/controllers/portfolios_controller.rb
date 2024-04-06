class PortfoliosController < ApplicationController
  def index
    @users = User.all # or any other query to retrieve users
  end

  def new
    @subscription = Subscription.new
  end

  def create
    user = User.find(params[:user_id])
    @subscription = Subscription.new(subscribable: current_user, user: user)
    if @subscription.save
      flash[:notice] = 'Subscribed successfully!'
    else
      flash[:alert] = 'Subscription failed!'
    end
    redirect_to user_portfolios_path(current_user)
  end

  def destroy
    subscribable_user = User.find(params[:user_id])
    user = User.find(params[:id])
    subscription = current_user.subscriptions.find_by(subscribable: subscribable_user, user: user)
    if subscription.destroy
      flash[:notice] = 'Unsubscribed successfully!'
    else
      flash[:alert] = 'Unsubscription failed!'
    end
    redirect_to user_portfolios_path(current_user)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:subscribable_id, :subscriber_id)
  end
end
