require 'rails_helper'

RSpec.describe ShopifyController, type: :controller do
  describe 'GET #products' do
    context 'when the request is successful' do
      let(:products) do
        [
          { 'id' => 123456789, 'title' => 'Product 1', 'body_html' => '<strong>Good product!</strong>', 'vendor' => 'Vendor 1' },
          { 'id' => 987654321, 'title' => 'Product 2', 'body_html' => '<strong>Another good product!</strong>', 'vendor' => 'Vendor 2' }
        ]
      end

      before do
        allow(ShopifyService).to receive(:fetch_products).and_return(products)
        get :products
      end

      it 'calls the ShopifyService to fetch products' do
        expect(ShopifyService).to have_received(:fetch_products)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the products as JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq(products)
      end
    end

    context 'when an error occurs' do
      before do
        allow(ShopifyService).to receive(:fetch_products).and_raise(StandardError.new('Something went wrong'))
        get :products
      end

      it 'returns an internal server error response' do
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns the error message as JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Something went wrong')
      end
    end
  end
end