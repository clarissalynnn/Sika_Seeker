class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

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
