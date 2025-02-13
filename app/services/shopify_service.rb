require 'net/http'
require 'json'

# ShopifyService is a service class responsible for interacting with the Shopify API.
# It provides methods to fetch products, synchronize products with the local database,
# and synchronize inventory quantities.

# Methods:
# - self.fetch_products: Fetches all products from the Shopify store.
# - self.sync_products: Fetches all products from the Shopify store and updates the local database.
# - self.sync_inventory: Synchronizes inventory quantities for all products in the local database.
# - self.fetch_product_data(shopify_id): Fetches data for a specific product from the Shopify store.

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
end