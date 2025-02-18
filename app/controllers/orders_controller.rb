class OrdersController < ApplicationController
  # GET /orders
  # Retrieves a list of all orders.
  #
  # Response:
  # - 200 OK: Returns a JSON array of all orders.
  # - 500 Internal Server Error: Returns a JSON object with an error message.
  def index
    orders = Order.recent
    render json: orders, each_serializer: OrderSerializer
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end