require_relative '../services/shopify_service'

# ShopifyController handles various Shopify-related actions such as fetching products,
# syncing products, inventory, orders, and customers with the Shopify service.
#
# Actions:
# - products: Fetches products from Shopify and renders them as JSON.
# - sync_products: Syncs products with Shopify and renders a success message as JSON.
# - sync_inventory: Syncs inventory with Shopify and renders a success message as JSON.
# - sync_orders: Syncs orders with Shopify and renders a success message as JSON.
# - sync_customers: Syncs customers with Shopify and renders a success message as JSON.
#
# In case of any errors during these actions, an error message is rendered as JSON with
# a status of internal server error.
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

  def sync_orders
    ShopifyService.sync_orders
    render json: { message: 'Orders synced successfully' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def sync_customers
    ShopifyService.sync_customers
    render json: { message: 'Customers synced successfully.' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end