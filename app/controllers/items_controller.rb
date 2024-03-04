class ItemsController < ApplicationController
  def index
  end

  def wheel
    @all_meals = Items.pluck(:name)

  end
end
