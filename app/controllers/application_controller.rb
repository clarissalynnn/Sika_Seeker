class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end

# class ApplicationController < ActionController::Base
#   before_action :configure_permitted_parameters, if: :devise_controller?

#   private

#   # Method to configure permitted parameters for Devise
#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
#     devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
#   end
# end
