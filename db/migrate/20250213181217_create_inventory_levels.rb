class CreateInventoryLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_levels do |t|
      t.integer :product_id
      t.integer :shopify_item_id
      t.integer :available

      t.timestamps
    end
  end
end
