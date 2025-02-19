Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :api do
    namespace :v1 do
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
  end
end
