
FinnhubRuby.configure do |config|
  config.api_key['api_key'] = Rails.application.credentials.dig(:finnhub, :api_key)
end
