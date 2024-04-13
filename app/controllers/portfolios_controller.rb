class PortfoliosController < ApplicationController
  def show
    @user = User.find(params[:id])

    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @usertxns = Transaction.where(user_ticker: @user.user_tickers)
    @alltickers = Ticker.all
    @txn_count = 0
    @usertickers = UserTicker.all

    # Extracting relevant information from @usertxns
    transactions_info = @usertxns.map do |txn|
      ticker_symbol = txn.user_ticker.ticker.name  # Assuming user_ticker is associated with the UserTicker model
      "#{txn.flow} transaction for #{ticker_symbol} at $#{txn.txnprice} per share"
    end

    # Formatting the prompt
    prompt = "Here are the recent transactions:\n#{transactions_info.join("\n")}\n\nPlease give some insights to the transactions."

    # Calling OpenAI service to generate a summary
    summary_response = OpenaiApiClient.create_chat(prompt)

    # Extracting the summary from the response
    @summary = summary_response["choices"].first["message"]["content"]
  end

  def me
    redirect_to portfolio_path(current_user)
  end
end
