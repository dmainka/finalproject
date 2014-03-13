class AddIndexToUsersEmail < ActiveRecord::Migration

  def self.up
    add_index :users, :email, unique: true
    change_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_index :users, :email
    change_column :users, :admin, :boolean, :default => nil
  end

end
