Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Route to check the health of the application
  get 'check_health', to: 'health#check_health'

  # Route to sync posts from an external service
  get 'sync/posts', to: 'sync#sync_posts'

  # Routes for CRUD operations on posts
  resources :posts, only: [:index, :show, :create, :update, :destroy]

  # Route to fetch products from Shopify
  get 'shopify/products', to: 'shopify#products'

  # Route to sync products from Shopify
  get 'shopify/sync_products', to: 'shopify#sync_products'

  # Route to sync inventory from Shopify
  get 'shopify/sync_inventory', to: 'shopify#sync_inventory'

  # Route to sync orders from Shopify
  get 'shopify/sync_orders', to: 'shopify#sync_orders'

  # Route to sync customers from Shopify
  get 'shopify/sync_customers', to: 'shopify#sync_customers'

  # Route to fetch products
  get 'products', to: 'products#index'

  # Route to fetch customers
  get 'customers', to: 'customers#index'

  # Route to fetch orders
  get 'orders', to: 'orders#index'
end
