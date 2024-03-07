class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Redirect after sign in
  def after_sign_in_path_for(*)
    items_index_path
  end
end
