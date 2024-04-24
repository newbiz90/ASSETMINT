class WatchlistController < ApplicationController
  def show
    @tickerSubs = current_user.subscriptions.where(subscribable_type: "UserTicker")
  end

  def followtickerform
  end
end
