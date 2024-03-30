Rails.application.routes.draw do
  # Routes for Devise authentication
  devise_for :users

  # Routes for tickers
  resources :tickers do
    # Nested routes for news snippets associated with tickers
    resources :news_snippets, only: [:index, :create, :destroy]
  end

  # Routes for user_tickers
  resources :user_tickers, only: [:index, :create, :destroy]

  # Define root path
  root to: "pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for dashboard
  get 'dashboard', to: 'dashboard#index'
end
