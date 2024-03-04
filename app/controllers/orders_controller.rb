class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @orders = Order.all
  end
end
