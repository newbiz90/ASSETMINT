class WatchlistController < ApplicationController
  def show
  end

  def followtickerform
    @newticker = Subscription.new
    raise
  end
end
