class ItemsController < ApplicationController
  def index
    # @all_meals = Item.pluck(:name, :photo, :price) #nested arr with name, photo, price
    # @random_dishes = @all_meals.sample(4)
    # # raise

    @filter_price = params[:price]
    @all_meals = Item.pluck(:name, :photo, :price)
    @random_dishes = @all_meals.sample(4)
    if @filter_price.present?
      # ? => placeholder
      @filtered_meals = Item.where("price < ?", @filter_price).pluck(:name, :photo, :price)
      @random_dishes = @filtered_meals.sample(4)
    end

  end

end
