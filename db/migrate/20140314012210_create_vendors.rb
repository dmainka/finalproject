class CreateVendors < ActiveRecord::Migration

  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end

end
