Rails.application.routes.draw do

  # Routes for the spinning wheel
  get 'pages/home', to: 'pages#home', as: 'home'
  get 'about', to: 'pages#about', as: 'about'
  get 'pages/wheel' => "pages#wheel"
  post 'pages/wheel' => "pages#wheel_api"


# Route for the loading page
  get 'loading', to: 'loading#show'
  root to: "pages#home"

  # items routes
  get 'items/index', to: "items#index"

  # Devise routes for users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/orders/:id", to: "orders#show", as: :order
  # for users and drivers
  get "/orders", to: "orders#index"
  post "/orders", to: "orders#create"
  post 'orders/:id/in_progress', to: 'orders#in_progress', as: 'in_progress_order'
  post 'orders/:id/out_for_delivery', to: 'orders#out_for_delivery', as: 'out_for_delivery_order'
  post 'orders/:id/completed', to: 'orders#completed', as: 'completed_order'
  patch 'orders/:id/update', to: 'orders#update', as: 'update_order'
  get 'orders/:id/checkout', to: 'orders#checkout', as: 'checkout'

  # Update quantity
  get "orders/:id/update-quantity", to: 'orders#update_quantity', as: 'update_quantity'

  # Order Add Address page
  # get "/orders/:id/address", to: "orders#address", as: 'order_address'
  # Order Update Address page
  post "/orders/:id/update-address", to: "orders#update_address", as: 'update_address'

  # Order track page
  get "/orders/:id/track", to: "orders#track", as: 'track_order'

  # Defines the root path route ("/")

  # Delete order item from the cart
end
