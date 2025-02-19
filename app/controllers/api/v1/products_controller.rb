module Api
  module V1
    class ProductsController < ApplicationController
      # GET /products
      # Fetches all products from the database and returns them as a JSON response.
      # If an error occurs, it returns a JSON response with the error message and a 500 status code.
      #
      # @return [JSON] JSON representation of all products or an error message.
      def index
        products = Product.recent
        render json: products
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end