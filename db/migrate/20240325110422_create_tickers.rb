class CreateTickers < ActiveRecord::Migration[7.1]
  def change
    create_table :tickers do |t|
      t.string :name

      t.timestamps
    end
  end
end
