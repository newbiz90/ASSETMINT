class SubscriptionsController < ApplicationController
  def following
    if params[:email] # Check if email parameter is present
      @user = User.find_by('lower(email) = ?', params[:email]&.downcase)
      if @user
        @transactions = @user.transactions.includes(user_ticker: :ticker)
      else
        @transactions = []
        flash[:alert] = "User not found."
        redirect_to root_path # Redirect somewhere appropriate if user not found
        return # Ensure we exit the method after the redirect to avoid further processing
      end
    else # Handle existing functionality if no email is provided
      subscribed_user_ids = current_user.subscriptions.where(subscribable_type: 'User').pluck(:subscribable_id)
      @transactions = fetch_enriched_transactions(subscribed_user_ids)
    end
  end

  def create
    subscribable = determine_subscribable(params[:subscription][:subscribable_type],
                                          params[:subscription][:subscribable_id])
    @subscription = Subscription.new(subscribable:, user: current_user)

    if @subscription.save
      flash[:notice] = 'Subscribed successfully!'
    else
      flash[:alert] = 'Subscription failed!'
    end
    respond_to do |format|
      format.html { redirect_to community_path }

      format.json  { render json: { msg: :ok } }
    end
  end

  def destroy
    subscription = current_user.subscriptions.find_by(id: params[:id])

    if subscription.destroy
      flash[:notice] = 'Unsubscribed successfully!'
    else
      flash[:alert] = 'Unsubscription failed!'
    end

    respond_to do |format|
      format.html { redirect_to community_path }

      format.json  { render json: { msg: :ok } }
    end
  end

  private

  # Enriches transactions with current price and P/L calculations
  def fetch_enriched_transactions(subscribed_user_ids)
    Transaction.joins(user_ticker: :user)
               .where(user_ticker: { user_id: subscribed_user_ids })
               .distinct

    # transactions.each do |transaction|
    #   transaction.current_price = transaction.fetch_current_price
    #   transaction.pl = transaction.calculate_pl
    # end
  end

  # Determines the subscribable entity based on the type
  def determine_subscribable(type, id)
    case type
    when 'User'
      User.find(id)
    when 'UserTicker'
      UserTicker.find(id)
    end
  end
end
