class SubscriptionsController < ApplicationController

  def index
    @subs = Subscription.all
  end

end
