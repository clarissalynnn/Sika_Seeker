class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def wheel
    filter
  end

  def wheel_api
    p params
    filter
  end

  private

  def filter
    @filter_price = params[:price].to_i
    @all_meals = Item.all.to_a
    @random_dishes = []

    if @filter_price.present?
      total_price = 0
      # random reorder  @all_meals
      @all_meals.shuffle.each do |dish|
        # skips and looks for dishes > @filter_price
        next if total_price + dish.price > @filter_price
        total_price += dish.price
        @random_dishes << [dish.name, ActionController::Base.helpers.asset_url(dish.photo), dish.price]
        break if @random_dishes.length >= 4
      end
    else
      @random_dishes = @all_meals.sample(4).pluck(:name, :photo, :price)
    end
  end


end
