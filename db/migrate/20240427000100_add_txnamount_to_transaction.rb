class AddTxnamountToTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :txnamt, :decimal, precision: 10, scale: 2
  end
end
