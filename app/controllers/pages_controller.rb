class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def wheel
    filter
  end

  def wheel_api
    p params
    filter
  end

  def about
  end

  private

  def filter
  @filter_price = params[:price].to_i
  @random_dishes = []
  suitable_dishes = []

  categories = Item.pluck(:category).uniq

  while @filter_price > 0 do
    categories.each do |category|
      items = Item.where(category: category)

      suitable_items = items.select { |item| item.price <= @filter_price }

      # Randomly pick a suitable dish from this category
      if suitable_items.any?
        @random_item = suitable_items.sample
        @random_dishes << [random_item.name, ActionController::Base.helpers.asset_url(random_item.photo), random_item.price]
        @filter_price -= random_item.price  # Deduct price from filtered price

        # break loop when filter price <= zero
        break if @filter_price <= 0
      end
    end
  end
  @random_dishes
end
end
