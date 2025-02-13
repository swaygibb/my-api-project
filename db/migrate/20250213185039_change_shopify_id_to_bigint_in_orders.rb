class ChangeShopifyIdToBigintInOrders < ActiveRecord::Migration[8.0]
  def change
    change_column :orders, :shopify_id, :bigint
  end
end
