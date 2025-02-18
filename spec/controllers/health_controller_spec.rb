require 'rails_helper'

RSpec.describe HealthController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #check_health' do
    context 'when both database and external service are healthy' do
      before do
        allow(controller).to receive(:check_database).and_return(true)
        allow(controller).to receive(:check_external_service).and_return(true)
        get :check_health
      end

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns health status as ok' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('ok')
      end
    end

    context 'when database is healthy but external service is not' do
      before do
        allow(controller).to receive(:check_database).and_return(true)
        allow(controller).to receive(:check_external_service).and_return(false)
        get :check_health
      end

      it 'returns status service_unavailable' do
        expect(response).to have_http_status(:service_unavailable)
      end

      it 'returns health status as partial' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('partial')
      end
    end

    context 'when database is not healthy but external service is' do
      before do
        allow(controller).to receive(:check_database).and_return(false)
        allow(controller).to receive(:check_external_service).and_return(true)
        get :check_health
      end

      it 'returns status service_unavailable' do
        expect(response).to have_http_status(:service_unavailable)
      end

      it 'returns health status as partial' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('partial')
      end
    end

    context 'when both database and external service are not healthy' do
      before do
        allow(controller).to receive(:check_database).and_return(false)
        allow(controller).to receive(:check_external_service).and_return(false)
        get :check_health
      end

      it 'returns status service_unavailable' do
        expect(response).to have_http_status(:service_unavailable)
      end

      it 'returns health status as partial' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('partial')
      end
    end
  end
end