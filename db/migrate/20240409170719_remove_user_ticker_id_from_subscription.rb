class RemoveUserTickerIdFromSubscription < ActiveRecord::Migration[7.1]
  def change
    remove_column :subscriptions, :user_ticker_id, :bigint
  end
end
