class AddUserRelationships < ActiveRecord::Migration
  def self.up
    add_column :products, :seller_id, :integer
    add_index :products, :seller_id

    add_column :orders, :seller_id, :integer
    add_index :orders, :seller_id
  end

  def self.down
    remove_index :products, :seller_id
    remove_column :products, :seller_id
    
    remove_index :orders, :seller_id
    remove_column :orders, :seller_id
  end
end
