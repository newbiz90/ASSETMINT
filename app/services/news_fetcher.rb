class NewsFetcher
  def self.fetch_news_for_ticker(ticker_name)
    # Implementation of fetching news
    # Ensure this method returns [] if no news or in case of error
    begin
      # Your existing implementation...
      # Assuming an API call is made and its response is parsed

      # If the API call fails or returns no news items, return an empty array
      return []
    rescue => e
      Rails.logger.error "Failed to fetch news for ticker #{ticker_name}: #{e.message}"
      return []
    end
  end
end
