Rails.application.routes.draw do

  get 'items/index' => "items#index"
  get 'pages/wheel' => "pages#wheel"
  post 'pages/wheel' => "pages#wheel_api"


# Route for the loading page
  get 'loading', to: 'loading#show'
  root to: "loading#show"

  # items routes
  get 'items/index', to: "items#index"
  get 'items/roulette', to: "items#roulette"

  # Devise routes for users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/orders/:id", to: "orders#show", as: :order
  get "/orders", to: "orders#index"
  post "/orders", to: "orders#create"

  # Order track page
  get "/orders/:id/track", to: "orders#track"
  # Defines the root path route ("/")
end
