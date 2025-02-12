require_relative '../services/json_placeholder_sync_service'

class SyncController < ApplicationController
  def sync_posts
    JsonPlaceholderSyncService.sync_posts
    render json: { message: 'Posts synced successfully.', timestamp: Time.now }, status: :ok
  end
end
