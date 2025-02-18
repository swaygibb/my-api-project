require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    context 'when there are proudcts' do
      let!(:product) do
        create(:product, shopify_id: "order_#{SecureRandom.hex(10)}")
      end

      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'returns all products as JSON' do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(1)
      end
    end
  end
end

