require 'net/http'
require 'json'

class JsonPlaceholderSyncService
  API_POSTS_URL = "#{ENV['EXTERNAL_SERVICE_URL']}/posts".freeze

  def self.sync_posts
    uri = URI(API_POSTS_URL)
    response = Net::HTTP.get(uri)

    posts = JSON.parse(response)

    posts.each do |post_data|
      Post.find_or_create_by(id: post_data['id']) do |post|
        post.title = post_data['title']
        post.body = post_data['body']
        post.user_id = post_data['userId']
      end
    end
  end
end