class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    if (params[:add])
      if session[:cart]
        cart = session[:cart]
        cart[params[:add]] += 1
        # { 2: 1, 3: 2 }
      end
    end

    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end


end
