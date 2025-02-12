require 'rails_helper'

RSpec.describe SyncController, type: :controller do
  describe 'GET #sync_posts' do
    context 'when syncing posts is successful' do
      before do
        allow(JsonPlaceholderSyncService).to receive(:sync_posts).and_return(true)
        get :sync_posts
      end

      it 'calls the sync_posts method on JsonPlaceholderSyncService' do
        expect(JsonPlaceholderSyncService).to have_received(:sync_posts)
      end

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Posts synced successfully.')
      end

      it 'returns a timestamp' do
        json_response = JSON.parse(response.body)
        expect(json_response['timestamp']).to be_present
      end
    end

    context 'when syncing posts fails' do
      before do
        allow(JsonPlaceholderSyncService).to receive(:sync_posts).and_raise(StandardError.new('Sync failed'))
        get :sync_posts
      end

      it 'returns status internal_server_error' do
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Sync failed')
      end
    end
  end
end