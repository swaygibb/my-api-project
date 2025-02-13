class Product < ApplicationRecord
  validates :shopify_id, presence: true, uniqueness: true
end
