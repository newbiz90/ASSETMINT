class AddUserRefToAssets < ActiveRecord::Migration[7.1]
  def change
    add_reference :assets, :user, null: false, foreign_key: true
  end
end
