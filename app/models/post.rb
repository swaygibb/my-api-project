class Post < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
end
