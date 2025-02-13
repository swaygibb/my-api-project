require 'net/http'
require 'json'

# ShopifyService is responsible for interacting with the Shopify API to fetch and sync data.
# It provides methods to fetch products, sync products, sync inventory, fetch product data, and sync orders.
#
# Methods:
# - self.fetch_products: Fetches all products from the Shopify store.
# - self.sync_products: Syncs products from the Shopify store to the local database.
# - self.sync_inventory: Syncs inventory quantities for all products in the local database.
# - self.fetch_product_data(shopify_id): Fetches data for a specific product by its Shopify ID.
# - self.sync_orders: Syncs orders from the Shopify store to the local database.

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

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

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
end