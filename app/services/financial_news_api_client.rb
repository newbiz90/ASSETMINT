class FinancialNewsApiClient
    API_ENDPOINT = "https://newsapi.org/v2/"

    class << self
        def top_headlines(countryCode = "us", category = "business")
            JSON.parse(api_call("top-headlines?country=#{countryCode}&category=#{category}&apiKey=#{FIN_NEWS_API_KEY}").body) 
        end

        private

        def api_call(path)
            RestClient.get("#{API_ENDPOINT}/#{path}")
        end
    end
end
  