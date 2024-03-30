class NewsSnippetsController < ApplicationController
  def index
    @news_snippets = NewsSnippet.includes(:ticker).all

    # Initialize the Finnhub client
    finnhub_client = FinnhubRuby::DefaultApi.new

    # Fetch market news from Finnhub
    begin
      @finnhub_news = finnhub_client.market_news('general', {min_id: 0})
    rescue => e
      @finnhub_news = [] # In case of an API error, ensure @finnhub_news is an array to avoid errors in the view.
      Rails.logger.error "Failed to fetch Finnhub news: #{e.message}"
    end
  end
end
