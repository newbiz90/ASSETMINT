# config/initializers/telegram.rb

require 'telegram/bot'

TELEGRAM_BOT_TOKEN = ENV['TELEGRAM_BOT_TOKEN']

TELEGRAM_BOT = Telegram::Bot::Client.new(TELEGRAM_BOT_TOKEN)
