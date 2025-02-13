# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins "example.com"
#
#     resource "*",
#       headers: :any,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '69b9-65-61-72-107.ngrok-free.app'  # Appsmith's local URL
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end