class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscribable, polymorphic: true, null: false
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
