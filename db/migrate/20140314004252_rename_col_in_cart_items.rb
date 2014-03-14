class RenameColInCartItems < ActiveRecord::Migration
  def change
    rename_column :cart_items, :customer_id, :user_id
    rename_column :orders, :customer_id, :user_id
  end
end
