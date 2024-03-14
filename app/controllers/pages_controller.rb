class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def wheel
    filter
  end

  def wheel_api
    p params
    filter
  end

  def create
    # binding.break
    order = Order.create(
    order_date: Date.today,
    customer_id: current_user.id,
    driver_id: User.driver.first.id,
    total_price: 0,
    status: "pending"
    )

    params[:order][:item_ids].split(",").each do |item|
      OrderItem.create(
        item_id: item.to_i,
        order_id: order.id,
        quantity: 1
      )
    end

    order = Order.find(order.id)
    total_price = 0
    order.order_items.each do |order_item|
      total_price += order_item.item.price
    end
    order.update(total_price: total_price)
    # redirect_to orders_path
    redirect_to checkout_path(order)
  end

  # private

  def filter
    @filter_price = params[:price].to_i
    @random_dishes = []
    suitable_dishes = []

    @rice_items = Item.where(category: 'rice').select { |item| item.price <= @filter_price }

    if @rice_items.any?
      @random_item = @rice_items.sample
      @random_dishes << [@random_item.name, ActionController::Base.helpers.asset_url(@random_item.photo), @random_item.price, @random_item.id]
      @filter_price -= @random_item.price  # Deduct price from @filtered_price
    end

    categories = Item.where.not(category: 'rice').pluck(:category).uniq


    while @filter_price > 0 do
      break unless Item.all.where.not(category: 'rice').any? { |item| item.price <= @filter_price && @random_dishes.none? {|random_dish| random_dish.first == item.name } }

      categories.each do |category|
        items = Item.where(category: category)

        suitable_items = items.select do |item|
          if @random_dishes.any? {|random_dish| random_dish.first == item.name}
            false
          else
            item.price <= @filter_price
          end
        end

        # Randomly pick a suitable dish from this category
        if suitable_items.any?
          @random_item = suitable_items.sample
          @random_dishes << [@random_item.name, ActionController::Base.helpers.asset_url(@random_item.photo), @random_item.price, @random_item.id]
          @filter_price -= @random_item.price  # Deduct price from @filtered_price

          # break loop when @filtered_price <= zero
          break if @filter_price <= 0
        end
      end
    end
    @random_dishes
  end
end
