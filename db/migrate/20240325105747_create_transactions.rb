class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :asset, null: false, foreign_key: true
      t.string :flow
      t.date :txndate
      t.decimal :txnprice
      t.decimal :qty
      t.text :comment

      t.timestamps
    end
  end
end
