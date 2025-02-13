require_relative '../services/shopify_service'

# ShopifyController handles requests related to Shopify products.
# It provides actions to fetch and sync products with Shopify.

# Actions:
# - products: Fetches products from Shopify and returns them as JSON.
#   - GET /shopify/products
#   - Response: JSON array of products or error message with status 500.

# - sync_products: Syncs products with Shopify and returns a success message.
#   - POST /shopify/sync_products
#   - Response: JSON message indicating success or error message with status 500.

# - sync_inventory: Syncs products with Shopify and returns a success message.
#   - POST /shopify/sync_inventory
#   - Response: JSON message indicating success or error message with status 500.
class ShopifyController < ApplicationController
  def products
    products = ShopifyService.fetch_products
    render json: products
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def sync_products
    ShopifyService.sync_products
    render json: { message: 'Products synced successfully' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def sync_inventory
    ShopifyService.sync_inventory
    render json: { message: 'Inventory synced successfully' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end