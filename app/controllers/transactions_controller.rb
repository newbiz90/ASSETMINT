class TransactionsController < ApplicationController
  def index
    @mytxns = Transaction.joins(:user_ticker).where(user_ticker:{user: current_user})
    @alltickers = Ticker.all
    @usertickers = UserTicker.all
    @txn_count = 0
  end

  def new
    @transaction = Transaction.new
    @alltickers = Ticker.all
  end

  def create
    ticker_name = params[:transaction][:ticker_id]
    ticker = Ticker.find_by(name: ticker_name)

    @transaction = Transaction.new(transaction_params)
    @transaction.user_ticker = current_user.user_tickers.find_or_create_by(ticker: ticker)

    if @transaction.save
      flash[:notice] = 'Transaction was successfully created.'
      redirect_to user_transactions_path(current_user)
    else
      flash.now[:alert] = 'Transaction could not be created.'
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:flow, :txndate, :txnprice, :qty, :comment)
  end
end
