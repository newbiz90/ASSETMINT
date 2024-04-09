class PolygonApiClient
    API_ENDPOINT = "https://api.polygon.io/v2"

    class << self
        def get_news(ticker_symbols)
            return unless ticker_symbols.present?

            promises = ticker_symbols.map do |ticker_symbol|
                Concurrent::Promise.execute { JSON.parse(api_call("reference/news?ticker=#{ticker_symbol}").body) }
            end

            results = promises.map(&:value).flat_map { |result| result&.dig("results") }.compact
            results.map do |result|
                ticker_symbol = (result["tickers"] && ticker_symbols).first
                
                next unless ticker_symbol.present?

                ticker = Ticker.find_or_create_by(name: ticker_symbol)

                NewsSnippet.create(
                    ticker:,
                    title: result["title"],
                    content: result["description"],
                    article_url: result["article_url"],
                    keywords: result["keywords"],
                    tickers: result["tickers"],
                    publisher_logo_url: result.dig("publisher", "logo_url"),
                    publisher_name: result.dig("publisher", "name")
                )
            end
        end

        private

        def api_call(path)
            RestClient.get(
                "#{API_ENDPOINT}/#{path}",
                { Authorization: "Bearer #{ENV["POLYGON_API_KEY"]}"}
            )
        end
    end
end
  