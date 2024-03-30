Rails.application.routes.draw do
  # Define root path
  root to: "pages#home"

  # Routes for Devise authentication
  devise_for :users

  # Routes for users
  resources :users do
    # Nested routes for subscriptions associated with users
    resources :subscriptions, only: [:index, :create, :destroy]

    # Nested routes for transactions associated with users
    resources :transactions, only: [:index, :create, :update, :destroy]

    # Route for following and unfollowing users
    post 'follow', on: :member
    delete 'unfollow', on: :member
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
  get '/portfolio', to: 'portfolio#index', as: 'portfolio'
  get '/portfolio/search', to: 'portfolio#search', as: 'search_portfolio'
end
