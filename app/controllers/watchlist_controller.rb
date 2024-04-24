class WatchlistController < ApplicationController
  def show
    @tickerSubscriptions = current_user.subscriptions.where(subscribable_type: "UserTicker")
  end

  def followtickerform
  end
end
