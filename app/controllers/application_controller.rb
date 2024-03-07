class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Redirect after sign in
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.is_driver?
      orders_path
    else
      items_index_path
    end
  end
end
