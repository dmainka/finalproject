class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.datetime :order_date
      t.decimal :total
      t.string :ship_to_name
      t.text :ship_to_address
      t.string :payment_type

      t.timestamps
    end
  end
end
