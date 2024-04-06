class DashboardsController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def index
    @transaction = Transaction.new
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @alltickers = Ticker.all
    @usertickers = UserTicker.all
    @txn_count = 0
  end
end
