class TransactionsController < ApplicationController

  def index
    @alltxn = Transaction.all
    @ticker = Ticker.all
    # raise
  end

end
