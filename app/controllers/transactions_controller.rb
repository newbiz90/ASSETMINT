class TransactionsController < ApplicationController

  def index
    # @alltxn = Transaction.all
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})

    # @me = User_tickers.find(params(user_id))

    # @mytxns =
    @ticker = Ticker.all
    # raise
  end

end
