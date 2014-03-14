class AddPrecisionToDecimalCols < ActiveRecord::Migration

  def self.up
   change_column :orders, :total, :decimal, :precision => 8, :scale => 2
   change_column :products, :price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
   change_column :orders, :total, :decimal
   change_column :products, :price, :decimal
  end
end
