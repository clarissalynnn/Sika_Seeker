Rails.application.routes.draw do

  get 'items/index' => "items#index"
=======
# Route for the loading page
  get 'loading', to: 'loading#show'
  root to: "loading#show"

# Devise routes for users

  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/orders/:id", to: "orders#show", as: :order
  get "/orders", to: "orders#index"
  # Defines the root path route ("/")

end
