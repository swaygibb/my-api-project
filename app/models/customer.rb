class Customer < ApplicationRecord
  validates :shopify_id, presence: true, uniqueness: true
end
