require 'rails_helper'

RSpec.describe JsonPlaceholderSyncService, type: :service do
  describe '.sync_posts' do
    let(:posts_data) do
      [
        { 'title' => 'Post 1', 'body' => 'Body 1', 'userId' => 1 },
        { 'title' => 'Post 2', 'body' => 'Body 2', 'userId' => 2 }
      ]
    end

    before do
      stub_request(:get, "#{ENV['EXTERNAL_SERVICE_URL']}/posts")
        .to_return(status: 200, body: posts_data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    it 'fetches posts from the external service' do
      expect(Net::HTTP).to receive(:get).and_call_original
      JsonPlaceholderSyncService.sync_posts
    end

    it 'creates or updates posts in the database' do
      expect {
        JsonPlaceholderSyncService.sync_posts
      }.to change(Post, :count).by(2)

      posts_data.each do |post_data|
        post = Post.find_by(title: post_data['title'])
        expect(post).not_to be_nil
        expect(post.body).to eq(post_data['body'])
        expect(post.user_id).to eq(post_data['userId'])
      end
    end

    context 'when the external service returns an error' do
      before do
        stub_request(:get, "#{ENV['EXTERNAL_SERVICE_URL']}/posts")
          .to_return(status: 500, body: '', headers: {})
      end

      it 'raises an error' do
        expect {
          JsonPlaceholderSyncService.sync_posts
        }.to raise_error(StandardError)
      end
    end
  end
end