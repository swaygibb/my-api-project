require 'net/http'
require 'json'

# ShopifyService is a service class responsible for interacting with the Shopify API.
#
# This class provides a method to fetch products from a Shopify store.
#
# Methods:
#   - self.fetch_products: Fetches products from the Shopify store using the store name, API key, and access token from environment variables.
#
# Example usage:
#   products = ShopifyService.fetch_products
#
# Environment Variables:
#   - SHOPIFY_STORE_NAME: The name of the Shopify store.
#   - SHOPIFY_API_KEY: The API key for accessing the Shopify API.
#   - ADMIN_API_ACCESS_TOKEN: The access token for the Shopify admin API.
class ShopifyService
  def self.fetch_products
    uri = URI("https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/2021-04/products.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    JSON.parse(response.body)
  end
end