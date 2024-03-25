class CreateUserTickers < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tickers do |t|

      t.timestamps
    end
  end
end
