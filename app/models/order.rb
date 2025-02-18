class Order < ApplicationRecord
  validates :shopify_id, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
