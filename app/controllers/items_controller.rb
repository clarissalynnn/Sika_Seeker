class ItemsController < ApplicationController
  def index
    @all_meals = Item.pluck(:name, :photo, :price) #nested arr with name and photo
    @random_dishes = @all_meals.sample(4)
    # raise
  end

end
