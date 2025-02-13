class DropInventoryLevelsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :inventory_levels
  end

  def down
    create_table :inventory_levels do |t|
      t.integer :product_id
      t.integer :shopify_item_id
      t.integer :available

      t.timestamps
    end
  end
end