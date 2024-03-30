class AddIndexToTickers < ActiveRecord::Migration[7.1]
  def change
    add_index :tickers, :name
  end
end
