Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  mount Ckeditor::Engine => '/ckeditor'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  root to: 'pages#main'
  resources :products

  # scope ":locale", locale: /en|ru|ua/, defaults: {locale: 'ru'} do

  resources :line_items do
    put 'decrease_quantity'
    put 'increase_quantity'
  end

  resources :carts
  resources :orders
  resources :products do
    resources :line_items
  end
  get '/products_with_offers', to: 'products#only_with_discount'
  resources :searches
  resources :shares, only: %i[show index]
  resources :categories
  resources :users
  resources :comments
  resources :ratings, only: :update
  resources :useful_articles, only: %i[show index] do
    resources :comment_posts
  end

  resource :send_message, only: %i[new create]

  get '/products/:id/delete_image', to: 'products#delete_image', as: 'delete_image'

  get '/about' => 'pages#about'
  get '/contacts' => 'pages#contacts'
  get '/delivery' => 'pages#delivery'
  get '/payment' => 'pages#payment'
  get '/partners' => 'pages#partners'
  get '/main' => 'pages#main'

  resources :products do
    get :who_bought, on: :member
  end

  namespace :admin do
    root to: 'users#index'
    resources :users do
      get :banned_user, on: :member
      put :change_permission, on: :member
    end
    resources :orders do
      get :all_orders_delivered, on: :collection
      put :order_delivered, on: :member
    end
    resources :useful_articles
    resources :products do
      get :set_exchange_rates, on: :collection
      post :set_exchange_rates, to: 'products#update_products_with_exchange_rates', on: :collection
      collection { post :import }
      delete :delete_products_created_today, on: :collection
    end
    resources :categories do
      collection { post :sort }
    end
    resources :shares
  end

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
