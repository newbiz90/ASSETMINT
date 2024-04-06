class PortfoliosController < ApplicationController
  def index
    @users = User.all # or any other query to retrieve users
  end

  def create
    subscribable_user = User.find(params[:user_id])
    subscription = Subscription.new(subscribable: subscribable_user, subscriber: current_user)
    if subscription.save
      redirect_to portfolio_path, notice: 'Subscribed successfully!'
    else
      redirect_to portfolio_path, alert: 'Subscription failed!'
    end
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
end
