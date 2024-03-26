class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscribable, polymorphic: true, null: false
      t.references :user, foreign_key: true
      t.references :user_ticker, foreign_key: true

      t.timestamps
    end
  end
end
