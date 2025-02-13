FactoryBot.define do
  factory :order do
    shopify_id { "order_#{SecureRandom.hex(10)}" }
    total_price { 100.0 }
    currency { 'USD' }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
