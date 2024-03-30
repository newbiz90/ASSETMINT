class TransactionsController < ApplicationController

  def index
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @ticker = Ticker.all
    # raise
  end

end
