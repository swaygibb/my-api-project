require 'net/http'
require 'json'

class JsonPlaceholderSyncService
  API_POSTS_URL = "#{ENV['EXTERNAL_SERVICE_URL']}/posts".freeze

  def self.sync_posts
    uri = URI(API_POSTS_URL)
    response = Net::HTTP.get(uri)

    posts = JSON.parse(response)

    posts.each do |post_data|
      post = Post.find_or_initialize_by(title: post_data['title'], body: post_data['body'], user_id: post_data['userId'])
      post.save
    end
  end
end