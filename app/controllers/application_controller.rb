class ApplicationController < ActionController::API
  # Run the authenticate method before any action in this controller
  before_action :authenticate

  private

  # Authenticate the request using the Authorization header
  def authenticate
    # Get the token from the Authorization header
    token = request.headers['Authorization']

    # If the token does not match the expected token, return an unauthorized error
    unless token == ENV['AUTH_TOKEN']
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
