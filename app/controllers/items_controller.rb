class ItemsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index ]

  def index

    @items = Item.all

    if params[:query].present?
      @items = @items.where("name ILIKE ?", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "items/list", locals: {items: @items}, formats: [:html] }
    end

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

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to order_path, notice: "Item was successfully deleted."

  end
end
