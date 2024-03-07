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

  def drivers_orders_index
    # @driver =


  end



end
