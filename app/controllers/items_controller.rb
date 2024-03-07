class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

  def roulette
    @all_meals = Item.pluck(:name, :photo) #nested arr with name and photo
    @random_dishes = @all_meals.sample(4)
    # raise
    @order = Order.new
  end

  def index
    @rice_items = Item.all.select do |item|
      item.category == "rice"
    end

    @animal_items = Item.all.select do |item|
      item.category == "animal protein"
    end

    @plant_items = Item.all.select do |item|
      item.category == "plant protein"
    end

    @veg_items = Item.all.select do |item|
      item.category == "vegetables"
    end

    @order = Order.new
  end

end
