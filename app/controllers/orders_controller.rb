class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create ]
  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(
    order_date: Date.today,
    customer_id: 66,
    driver_id: 65,
    address: "Batu Bolong",
    total_price: 100
    )

    params[:order][:item_ids].split(",").each do |item|
      OrderItem.create(
        item_id: item.to_i,
        order_id: order.id,
        quantity: 1
      )
    end
    redirect_to orders_path
  end

  def track
    @order = Order.find(params[:id])

    @order_marker = {
        lat: @order.latitude,
        lng: @order.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {order: @order})
    }.to_json
  end

  def address
    @order = Order.find(params[:id])
  end

  def update_address
    # raise
    order = Order.find(params[:id])
    order.update(address: params[:order][:address], longitude: params[:order][:longitude].to_f,
                 latitude: params[:order][:latitude].to_f)

    redirect_to track_order_path(order)
  end
end
