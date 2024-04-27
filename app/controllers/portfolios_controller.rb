class PortfoliosController < ApplicationController
  def show
    @user = User.find(params[:id])
    @current_userID = current_user.id
    @transaction = Transaction.new
    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all

    @current_profit = @user.transactions.where(flow: "Sell").sum(:txnamt) - @user.transactions.where(flow: "Buy").sum(:txnamt)

    @actual_gain = begin
      sold_transactions = @user.transactions.where(flow: "Sell")
      bought_transactions = @user.transactions.where(flow: "Buy").order(txndate: :asc)

      sold_hash = {}

      sold_transactions.each do |txn|
        sold_hash[txn.user_ticker_id] ||= 0
        sold_hash[txn.user_ticker_id] += txn.qty
      end

      gains = 0

      bought_transactions.each do |txn|
        sold_hash[txn.user_ticker_id] ||= 0
        if sold_hash[txn.user_ticker_id] > 0
          if sold_hash[txn.user_ticker_id] > txn.qty
            sold_hash[txn.user_ticker_id] -= txn.qty
            gains += txn.txnamt
          else
            gains += sold_hash[txn.user_ticker_id] * txn.txnprice
            sold_hash[txn.user_ticker_id] = 0
          end
        end
      end

      # total_sold_amount = sold_transactions.sum(:txnamt)
      # total_sold_qty = sold_transactions.sum(:qty)
      # bought_transactions = @user.transactions.where(flow: "Buy").order(txndate: :asc)

      # total_bought_amount = 0
      # total_bought_qty = 0
      # bought_transactions.each do |txn|
      #   if total_bought_qty < total_sold_qty
      #     total_bought_amount += txn.txnamt
      #     total_bought_qty += txn.qty
      #   end
      # end

      # total_sold_amount - total_bought_amount
      gains
    end

    if params.dig(:search, :ticker_name).present?
      ticker = Ticker.find_by(name: params[:search][:ticker_name])
      filtered_user_ticker = UserTicker.where(ticker:, user: @user)
      @usertxns = Transaction.where(user_ticker: filtered_user_ticker).order(txndate: :desc).paginate(page: params[:page], per_page: 5)
    else
      @usertxns = @user.transactions.order(txndate: :desc).paginate(page: params[:page], per_page: 5)
    end
    # Calculate hash of transactions_info to use as version
    transactions_info_hash = Digest::SHA256.hexdigest(@usertxns.map { |txn| txn.cache_key }.join(","))

    # Fetch or generate summary from cache
    @summary = Rails.cache.fetch("portfolio_summary_#{params[:id]}_#{transactions_info_hash}", expires_in: 24.hour) do
      generate_summary
    end
  end

  def me
    redirect_to portfolio_path(current_user)
  end

  private

  def generate_summary
    # Extracting relevant information from @usertxns
    transactions_info = @usertxns.map do |txn|
      ticker_symbol = txn.user_ticker.ticker.name
      "#{txn.flow} transaction for #{ticker_symbol} at $#{txn.txnprice} per share"
    end

    # Formatting the prompt
    prompt = "Here are the recent transactions:\n#{transactions_info.join("\n")}\n\nPlease give some insights to the transactions."

    # Calling OpenAI service to generate a summary
    summary_response = OpenaiApiClient.create_chat(prompt)

    # Extracting the summary from the response
    summary_response["choices"].first["message"]["content"]
  end
end
