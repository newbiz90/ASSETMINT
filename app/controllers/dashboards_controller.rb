class DashboardsController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def show
    @user = current_user
    @transaction = Transaction.new
    @usertxns = current_user.transactions.limit(5)
    @alltickers = Ticker.all
    @usertickers = UserTicker.includes(:ticker).all
    @txn_count = 0

    @newstickers = UserTicker.includes(:ticker).sample(5)

    PolygonApiClient.get_news(@newstickers.map(&:ticker).map(&:name)) if params[:refresh_news] # refresh_news=true

    @news_snippets = NewsSnippet.where(
      ticker: @usertickers.map(&:ticker)
    ).order(created_at: :desc).limit(5)

    # Fetching headlines
    news_headlines = FinancialNewsApiClient.top_headlines

    # Extracting titles
    titles = news_headlines["articles"].map { |article| article["title"] }

    # Concatenating titles into a single prompt
    prompt = titles.join("\n")

    # Prompting for a passage summarization
    prompt += "\nSummarize the above headlines into a passage of not more than 50 words.\n"

    # Calling OpenAI service to generate a summary
    @summary = Rails.cache.fetch("openai_summary", expires_in: 4.hour) do
      summary_response = OpenaiApiClient.create_chat(prompt)
      summary_response["choices"].first["message"]["content"]
    end
  end
end
