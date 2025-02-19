require 'rails_helper'

RSpec.describe Api::V1::ShopifyController, type: :controller do
  include Devise::Test::ControllerHelpers

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

  describe 'GET #sync_products' do
    let(:products) do
      [
        { 'id' => 123456789, 'title' => 'Product 1', 'body_html' => '<strong>Good product!</strong>', 'vendor' => 'Vendor 1' },
        { 'id' => 987654321, 'title' => 'Product 2', 'body_html' => '<strong>Another good product!</strong>', 'vendor' => 'Vendor 2' }
      ]
    end

    before do
      allow(ENV).to receive(:[]).with('SHOPIFY_API_KEY').and_return('mock_api_key')
      allow(ENV).to receive(:[]).with('SHOPIFY_API_PASSWORD').and_return('mock_api_password')
      allow(ENV).to receive(:[]).with('SHOPIFY_STORE_NAME').and_return('mock_store_name')
      allow(ENV).to receive(:[]).with('AUTH_TOKEN').and_return('mock_auth_token')
      allow(ENV).to receive(:[]).with('ADMIN_API_ACCESS_TOKEN').and_return('mock_admin_api_token')
      allow(ENV).to receive(:[]).with('DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL').and_return('false')
      allow(ENV).to receive(:[]).with('DATABASE_CLEANER_ALLOW_PRODUCTION').and_return('false')
      allow(ENV).to receive(:[]).with('RAILS_CACHE_ID').and_return('mock_cache_id')

      request.headers['Authorization'] = 'mock_auth_token'

      stub_request(:get, "https://mock_store_name.myshopify.com/admin/api/2021-04/products.json")
        .with(headers: { 'Authorization' => /.*/ })
        .to_return(status: 200, body: { products: products }.to_json, headers: { 'Content-Type' => 'application/json' })

    end

    context 'when the request is successful' do
      before do
        get :sync_products
      end
    end

    context 'when an error occurs' do
      before do
        allow(ShopifyService).to receive(:fetch_products).and_raise(StandardError.new('Something went wrong'))
        get :sync_products
      end

      it 'returns the error message as JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq("Something went wrong")
      end
    end
  end

  describe 'POST #sync_inventory' do
    before do
      allow(ShopifyService).to receive(:sync_inventory).and_return(true)
      post :sync_inventory
    end

    it 'calls the ShopifyService to sync inventory' do
      expect(ShopifyService).to have_received(:sync_inventory)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a success message' do
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Inventory synced successfully')
    end
  end

  describe 'POST #sync_orders' do
    before do
      allow(ShopifyService).to receive(:sync_orders)
    end

    context 'when the sync is successful' do
      before { post :sync_orders }

      it 'calls the ShopifyService to sync orders' do
        expect(ShopifyService).to have_received(:sync_orders)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Orders synced successfully')
      end
    end

    context 'when an error occurs' do
      before do
        allow(ShopifyService).to receive(:sync_orders).and_raise(StandardError.new('Something went wrong'))
        post :sync_orders
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

  describe 'POST #sync_customers' do
    context 'when sync is successful' do
      before do
        allow(ShopifyService).to receive(:sync_customers).and_return(true)
        post :sync_customers
      end

      it 'calls the ShopifyService to sync customers' do
        expect(ShopifyService).to have_received(:sync_customers)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Customers synced successfully.')
      end
    end

    context 'when an error occurs' do
      before do
        allow(ShopifyService).to receive(:sync_customers).and_raise(StandardError.new('Something went wrong'))
        post :sync_customers
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