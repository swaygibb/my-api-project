require 'net/http'
require 'json'

# JsonPlaceholderSyncService is responsible for synchronizing posts from an external JSONPlaceholder API.
# It fetches posts data from the API and updates or creates corresponding Post records in the database.
#
# Constants:
# API_POSTS_URL - The URL of the external JSONPlaceholder API for fetching posts.
#
# Methods:
# self.sync_posts - Fetches posts from the external API and updates or creates Post records in the database.
#
# Example usage:
# JsonPlaceholderSyncService.sync_posts
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