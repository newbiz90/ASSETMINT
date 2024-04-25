class WatchlistController < ApplicationController
  def show
    @tickerSubs = current_user.subscriptions.where(subscribable_type: "UserTicker")

    @transactions = Transaction.where(user_ticker_id: @tickerSubs.map(&:subscribable_id))
  end

  def followtickerform
  end
end
