class FinnhubApiClient
  def self.get_news(category)
    JSON.parse(RestClient.get("https://finnhub.io/api/v1/news?category=#{category}}&token=#{ENV["FINNHUB_API_KEY"]}").body)
  end
end
