class TransactionsController < ApplicationController

  def index
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @alltickers = Ticker.all
    @usertickers = UserTicker.all
    @txn_count = 0
    # raise
  end

end
