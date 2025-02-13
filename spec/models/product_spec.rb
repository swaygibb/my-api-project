require 'rails_helper'

RSpec.describe Product, type: :model do
  # Define a valid set of attributes for a product
  let(:valid_attributes) do
    {
      title: 'Product 1',
      body_html: '<strong>Good product!</strong>',
      vendor: 'Vendor 1',
      product_type: 'Type 1',
      shopify_id: 123456789
    }
  end

  # Test validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = Product.new(valid_attributes)
      expect(product).to be_valid
    end

    it 'is not valid without a shopify_id' do
      product = Product.new(valid_attributes.except(:shopify_id))
      expect(product).not_to be_valid
      expect(product.errors[:shopify_id]).to include("can't be blank")
    end

    it 'is not valid with a duplicate shopify_id' do
      Product.create!(valid_attributes)
      product = Product.new(valid_attributes)
      expect(product).not_to be_valid
      expect(product.errors[:shopify_id]).to include('has already been taken')
    end
  end
end
