require 'net/http'
require 'json'

# ShopifyService is a service class responsible for interacting with the Shopify API.
# It provides methods to fetch and synchronize products from a Shopify store.

# Methods:
# - self.fetch_products: Fetches the list of products from the Shopify store.
#   - Returns: An array of products in JSON format.
#   - Raises: An error if the request to the Shopify API fails.

# - self.sync_products: Fetches the list of products from the Shopify store and synchronizes them with the local database.
#   - Finds or initializes a Product record by the Shopify product ID.
#   - Updates the Product record with the data fetched from Shopify.
#   - Raises: An error if the request to the Shopify API fails.
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

  def self.sync_products
    uri = URI("https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/2021-04/products.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    products = JSON.parse(response.body)['products']

    products.each do |product_data|
      product = Product.find_or_initialize_by(shopify_id: product_data['id'])
      product.update(
        title: product_data['title'],
        body_html: product_data['body_html'],
        vendor: product_data['vendor'],
        product_type: product_data['product_type']
      )
    end
  end
end