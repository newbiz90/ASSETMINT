
class Polygon::NewsSnippet < RemoteModel
  attr_accessor :title, 
                :description,
                :article_url, 
                :publisher_logo_url,
                :publisher_name,
                :keywords,
                :tickers
end