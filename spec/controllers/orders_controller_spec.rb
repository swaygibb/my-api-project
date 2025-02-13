require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    context 'when there are orders' do
      let!(:orders) do
        create(:order, shopify_id: "order_#{SecureRandom.hex(10)}")
      end

      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'returns all orders as JSON' do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(1)
      end
    end
  end
end

