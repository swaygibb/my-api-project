module Api
  module V1
    class CustomersController < ApplicationController
      # GET /customers
      # Fetches all customers from the database and returns them as a JSON response.
      # If an error occurs, it returns a JSON response with the error message and a 500 status code.
      def index
        customers = Customer.recent
        render json: customers
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end