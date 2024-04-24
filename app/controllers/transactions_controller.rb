class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
    @alltickers = Ticker.all
  end

  def index
    if params[:search].present? && params[:search][:ticker_name].present?
      @transactions = Transaction.filtered_transactions(params[:search][:ticker_name])
    else
      @transactions = Transaction.all
    end
  end

  def create
    ticker_name = params[:transaction][:ticker_id]
    ticker = Ticker.find_or_create_by(name: ticker_name)
    @transaction = Transaction.new(transaction_params)
    @transaction.user_ticker = current_user.user_tickers.find_or_create_by(ticker: ticker)
    @transaction.user = current_user

    if @transaction.save
      send_telegram_notification(current_user, @transaction)
      flash[:notice] = 'Transaction was successfully created.'
      redirect_to request.referer
    else
      flash.now[:alert] = 'Transaction could not be created.'
      render :new
    end
  end

  # DELETE /transactions/:id
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = 'Transaction was successfully destroyed.'
    redirect_to request.referer
  end

  private

  def transaction_params
    params.require(:transaction).permit(:flow, :txndate, :txnprice, :qty, :comment)
  end

  def send_telegram_notification(user, transaction)
    return unless ENV['TELEGRAM_BOT_TOKEN'] && ENV['TELEGRAM_CHAT_ID']

    message = "#{user.email} created a new transaction:\n"
    message += "Flow: #{transaction.flow}\n"
    message += "Date: #{transaction.txndate}\n"
    message += "Price: #{transaction.txnprice}\n"
    message += "Quantity: #{transaction.qty}\n"

    telegram_bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])
    telegram_bot.api.send_message(chat_id: ENV['TELEGRAM_CHAT_ID'], text: message)
  end
end
