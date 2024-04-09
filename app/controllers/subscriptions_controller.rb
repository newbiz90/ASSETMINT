class SubscriptionsController < ApplicationController
  def following
    subscribed_user_ids = current_user.subscriptions.where(subscribable_type: 'User').pluck(:subscribable_id)
    @transactions = Transaction.joins(user_ticker: :user)
                               .where(user_ticker: { user_id: subscribed_user_ids })
                               .distinct

    pp @transactions
  end

  def create
    subscribable = nil

    if params[:subscribable_type] == 'User'
      subscribable = User.find(params[:subscribable_id])
    elsif params[:subscribable_type] == 'UserTicker'
      subscribable = UserTicker.find(params[:subscribable_id])
    end

    @subscription = Subscription.new(subscribable:, user: current_user)
    
    if @subscription.save
      flash[:notice] = 'Subscribed successfully!'
    else
      flash[:alert] = 'Subscription failed!'
    end

    redirect_to community_path
  end

  def destroy
    subscription = current_user.subscriptions.find_by(id: params[:id])
    
    if subscription.destroy
      flash[:notice] = 'Unsubscribed successfully!'
    else
      flash[:alert] = 'Unsubscription failed!'
    end
    redirect_to portfolios_path
  end
end
