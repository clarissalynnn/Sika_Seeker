class ItemsController < ApplicationController
  def index
    @all_meals = Item.pluck(:name, :photo) #nested arr with name and photo
    @random_dishes = @all_meals.sample(4)
    # raise
    @order = Order.new
  end

end
