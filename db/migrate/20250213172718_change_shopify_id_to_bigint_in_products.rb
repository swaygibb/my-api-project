class ChangeShopifyIdToBigintInProducts < ActiveRecord::Migration[8.0]
  def change
    change_column :products, :shopify_id, :bigint
  end
end
