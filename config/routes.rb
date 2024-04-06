Rails.application.routes.draw do
  # Define root path
  root to: "pages#home"

  # Custom route for landing_page
  get '/landing_page', to: 'pages#landing'

  # Routes for Devise authentication
  devise_for :users

  # Routes for users
  resources :users do
    # Nested routes for subscriptions associated with users
    resources :subscriptions, only: [:index, :create, :destroy]

    # Nested routes for transactions associated with users
    resources :transactions, only: [:index, :create, :update, :destroy]

    # Nested routes for portfolios associated with users
    resources :portfolios, only: [:index, :create, :destroy]

    # Nested routes for dashboards associated with users
    resources :dashboards, only: [:index, :create, :destroy]
  end

  # Routes for tickers
  resources :tickers do
    # Nested routes for news snippets associated with tickers
    resources :news_snippets, only: [:index, :create, :destroy]
  end

  # Routes for user_tickers
  resources :user_tickers, only: [:index, :create, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  resources :news_snippets

  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for dashboard
  get 'dashboard', to: 'dashboard#index'

  # Routes for portfolio


  # Routes for subscriptions
  resources :subscriptions
end
