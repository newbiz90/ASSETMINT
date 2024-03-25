class AddTickerRefToUserTickers< ActiveRecord::Migration[7.1]
  def change
    add_reference :user_tickers, :ticker, null: false, foreign_key: true
  end
end
