class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    token = request.headers['Authorization']
    unless token == ENV['AUTH_TOKEN']
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
