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

    if params.dig(:search, :ticker_name).present?
      ticker = Ticker.find_by(name: params[:search][:ticker_name])
      filtered_user_ticker = UserTicker.where(ticker:, user: @user)
      @usertxns = Transaction.where(user_ticker: filtered_user_ticker).paginate(page: params[:page], per_page: 5)
    else
      @usertxns = @user.transactions.paginate(page: params[:page], per_page: 5)
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
