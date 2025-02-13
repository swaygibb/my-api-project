FactoryBot.define do
  factory :product do
    shopify_id { "order_#{SecureRandom.hex(10)}" }
    title { 'Product 1' }
    body_html { '<strong>Good product!</strong>' }
    vendor {'Vendor 1'}
  end
end
