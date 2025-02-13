require_relative '../services/shopify_service'

# Controller for handling Shopify related actions.
#
# This controller provides actions to interact with Shopify services.
#
# Actions:
# - products: Fetches and returns a list of products from Shopify.
#
# Methods:
# - products: Fetches products using ShopifyService and renders them as JSON.
#   If an error occurs, it returns a JSON response with the error message and a 500 status code.
class ShopifyController < ApplicationController
  def products
    products = ShopifyService.fetch_products
    render json: products
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end