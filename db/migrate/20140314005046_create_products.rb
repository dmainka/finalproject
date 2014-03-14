class CreateProducts < ActiveRecord::Migration

  def change
    create_table :products do |t|
      t.integer :vendor_id
      t.string :name
      t.text :description
      t.decimal :price
      t.string :image_url
      t.integer :department_id

      t.timestamps
    end
  end

end
