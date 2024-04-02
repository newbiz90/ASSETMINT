class SubscriptionsController < ApplicationController
  def index
    # Assuming you have a current_user method available
    # Fetch ids of users the current user has subscribed to
    subscribed_user_ids = current_user.subscriptions.where(subscribable_type: 'User').pluck(:subscribable_id)

    # Fetch transactions for tickers belonging to subscribed users
    @transactions = Transaction.joins(user_ticker: :user)
                               .where(user_tickers: { user_id: subscribed_user_ids })
                               .distinct
  end
end
