FactoryBot.define do
  factory :customer do
    shopify_id { "order_#{SecureRandom.hex(10)}" }
    first_name { "John" }
    last_name { "Doe" }
    email { "test@test.com" }
  end
end
