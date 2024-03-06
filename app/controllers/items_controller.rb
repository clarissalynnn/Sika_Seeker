class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

  def roulette
    @all_meals = Item.pluck(:name, :photo) #nested arr with name and photo
    @random_dishes = @all_meals.sample(4)
    # raise
  end

  def index
    @items = Item.all
  end
end
