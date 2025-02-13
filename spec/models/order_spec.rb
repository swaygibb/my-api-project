require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:shopify_id) }
    it { should validate_uniqueness_of(:shopify_id) }
  end
end
