# app/controllers/loading_controller.rb
class LoadingController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render layout: false # To render without application layout
  end
end
