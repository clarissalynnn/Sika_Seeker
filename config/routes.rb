Rails.application.routes.draw do

  get 'items/index' => "items#index"
  get 'pages/wheel' => "pages#wheel"
  post 'pages/wheel' => "pages#wheel_api"


# Route for the loading page
  get 'loading', to: 'loading#show'
  root to: "loading#show"

# Devise routes for users

  devise_for :users

  resources :orders

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
