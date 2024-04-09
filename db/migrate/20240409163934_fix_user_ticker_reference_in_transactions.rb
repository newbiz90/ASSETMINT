class FixUserTickerReferenceInTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :transactions, :user_tickers
    remove_column :transactions, :user_tickers_id
    add_reference :transactions, :user_ticker, foreign_key: true
  end
end
