class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @order = Order.new
    @markers = @orders.geocoded.map do |order|
      {
        lat: order.latitude,
        lng: order.longitude,
      	map_popup_html: render_to_string(partial: "map_popup", locals: { order: order }),
  		  marker_html: render_to_string(partial: "marker")
      }
    end
  end
end
