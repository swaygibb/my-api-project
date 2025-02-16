require 'net/http'
require 'json'

# ShopifyService is a service class responsible for interacting with the Shopify API.
# It provides methods to fetch and synchronize products, inventory, orders, and customers
# from a Shopify store to the local database.
#
# Constants:
# API_VERSION - The version of the Shopify API to use.
# BASE_URL - The base URL for the Shopify API, constructed using the store name and API version.
#
# Methods:
# .request_shopify_api(endpoint) - Sends a GET request to the specified Shopify API endpoint and returns the parsed JSON response.
# .fetch_products - Fetches all products from the Shopify store.
# .sync_products - Synchronizes products from the Shopify store to the local database.
# .sync_inventory - Synchronizes inventory quantities for products from the Shopify store to the local database.
# .fetch_product_data(shopify_id) - Fetches data for a specific product by its Shopify ID.
# .sync_orders - Synchronizes orders from the Shopify store to the local database.
# .sync_customers - Synchronizes customers from the Shopify store to the local database.
class ShopifyService
  API_VERSION = "2021-04"
  BASE_URL = "https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/#{API_VERSION}"

  def self.request_shopify_api(endpoint)
    uri = URI("#{BASE_URL}/#{endpoint}.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      { error: "Failed to parse JSON response", details: e.message }
    end
  end

  def self.fetch_products
    request_shopify_api("products")
  end

  def self.sync_products
    products = fetch_products["products"] || []
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

  def self.sync_inventory
    Product.find_each do |product|
      product_data = fetch_product_data(product.shopify_id)
      next unless product_data

      product.update(inventory_quantity: product_data['variants'].sum { |variant| variant['inventory_quantity'] })
    end
  end

  def self.fetch_product_data(shopify_id)
    request_shopify_api("products/#{shopify_id}")["product"]
  end

  def self.sync_orders
    orders = request_shopify_api("orders")["orders"] || []
    orders.each do |order_data|
      order = Order.find_or_initialize_by(shopify_id: order_data['id'])
      order.update(
        email: order_data['email'],
        total_price: order_data['total_price'],
        currency: order_data['currency'],
        order_number: order_data['order_number']
      )
    end
  end

  def self.sync_customers
    response = request_shopify_api("customers")
    puts "Response: #{response}"

    customers = response["customers"] || []
    customers.each do |customer_data|
      customer = Customer.find_or_initialize_by(shopify_id: customer_data['id'])
      customer.update(
        email: customer_data['email'],
        first_name: customer_data['first_name'],
        last_name: customer_data['last_name']
      )
    end
  end
end
