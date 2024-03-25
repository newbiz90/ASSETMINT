class AddUserRefToUserTickers < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_tickers, :user, null: false, foreign_key: true
  end
end
