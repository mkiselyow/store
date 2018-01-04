Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: "pages#main"
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
  resources :shares, only: [:show, :index]
  resources :categories
  resources :users
  resources :comments
  resources :ratings, only: :update
  resources :useful_articles, only: [:show, :index] do
    resources :comment_posts
  end
  
  resource :send_message, only: [:new, :create]
  
  get '/products/:id/delete_image', to: 'products#delete_image', as: 'delete_image'
  
  get '/about' => 'pages#about'
  get '/competitions' => 'pages#competitions'
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
      collection { post :import }
    end
    resources :categories do
      collection { post :sort }
    end
    resources :shares
  end
end
