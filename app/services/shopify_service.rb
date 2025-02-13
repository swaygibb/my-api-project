require 'net/http'
require 'json'

# ShopifyService is a service class that interacts with the Shopify API to fetch and sync data.
#
# Methods:
# - fetch_products: Fetches all products from the Shopify store.
# - sync_products: Fetches products from Shopify and updates or creates corresponding records in the local database.
# - sync_inventory: Syncs inventory quantities for all products in the local database with Shopify.
# - fetch_product_data: Fetches data for a specific product from Shopify using its Shopify ID.
# - sync_orders: Fetches orders from Shopify and updates or creates corresponding records in the local database.
# - sync_customers: Fetches customers from Shopify and updates or creates corresponding records in the local database.
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

  def self.sync_inventory
    products = Product.all
    products.each do |product|
      product_data = fetch_product_data(product.shopify_id)
      if product_data
        product.update(inventory_quantity: product_data['variants'].sum { |variant| variant['inventory_quantity'] })
      end
    end
  end

  def self.fetch_product_data(shopify_id)
    uri = URI("https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/2021-04/products/#{shopify_id}.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['product']
  end

  def self.sync_orders
    uri = URI("https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/2021-04/orders.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    orders = JSON.parse(response.body)['orders']

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
    uri = URI("https://#{ENV['SHOPIFY_STORE_NAME']}.myshopify.com/admin/api/2021-04/customers.json")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(ENV['SHOPIFY_API_KEY'], ENV['ADMIN_API_ACCESS_TOKEN'])
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

    customers = JSON.parse(response.body)['customers']

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