class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create ]
  def index
    @orders = Order.all.order(created_at: :desc)
    @driver = current_user
    @driver_orders = Order.where(driver_id: @driver.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    # binding.break
    order = Order.create(
      order_date: Date.today,
      customer_id: current_user.id,
      driver_id: User.driver.first.id,
      address: "Batu Bolong",
      total_price: 100,
      status: 0
    )

    params[:order][:item_ids].split(",").each do |item|
      OrderItem.create(
        item_id: item.to_i,
        order_id: order.id,
        quantity: 1
      )
    end
    # redirect_to orders_path
    redirect_to order_path(order)
  end

  def in_progress
    @order = Order.find(params[:id])
    if @order.update(status: 2)
      flash[:notice] = "Order in progress"
      redirect_to orders_path
    end
  end

  def out_for_delivery
    @order = Order.find(params[:id])
    if @order.update(status: 3)
      flash[:alert] = "Order out for delivery"
      redirect_to orders_path
    end
  end

  def completed
    @order = Order.find(params[:id])
    if @order.update(status: 4)
      flash[:alert] = "Order completed "
      redirect_to orders_path
    end
  end

  def track
    @order = Order.find(params[:id])

    @order_marker = {
      lat: @order.latitude,
      lng: @order.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {order: @order})
    }.to_json
  end

  def process_payment
    @order = Order.find(params[:id])
    if @order.update(status: 1)
      redirect_to order_path(@order), notice: 'Payment processed successfully.'
    else
      flash.now[:alert] = 'Failed to update order status.'
      render :show
    end
  end
end
