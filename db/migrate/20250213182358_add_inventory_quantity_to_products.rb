class AddInventoryQuantityToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :inventory_quantity, :integer
  end
end
