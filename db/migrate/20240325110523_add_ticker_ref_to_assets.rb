class AddTickerRefToAssets < ActiveRecord::Migration[7.1]
  def change
    add_reference :assets, :ticker, null: false, foreign_key: true
  end
end
