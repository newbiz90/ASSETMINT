class FinnhubApiClient
  def self.get_news(category)
    JSON.parse(RestClient.get("https://finnhub.io/api/v1/news?category=#{category}}&token=#{ENV["FINNHUB_API_KEY"]}").body)
  end

  def self.get_company_news(ticker, from_date, to_date)
    url = "https://finnhub.io/api/v1/company-news?symbol=#{ticker}&from=#{from_date}&to=#{to_date}&token=#{ENV['FINNHUB_API_KEY']}"
    response = RestClient.get(url)
    JSON.parse(response.body)
  end
end
