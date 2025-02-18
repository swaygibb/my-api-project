class OrderSerializer < ActiveModel::Serializer
  attributes(*Order.attribute_names.map(&:to_sym), :formatted_total_price)

  def formatted_total_price
    ActionController::Base.helpers.number_to_currency(object.total_price)
  end
end
