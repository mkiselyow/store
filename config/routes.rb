Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :line_items do
    put 'decrease_quantity'
    put 'increase_quantity'
  end

  resources :carts
  resources :orders
  resources :products do
    resources :line_items
  end
  resources :shares, only: [:show, :index]
  resources :categories
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users
  resources :comments
  resources :ratings, only: :update
  resources :useful_articles, only: [:show, :index] do
    resources :comment_posts
  end

  root to: "products#index"

  get '/products/:id/delete_image', to: 'products#delete_image', as: 'delete_image'

  get '/about' => 'pages#about'
  get '/competitions' => 'pages#competitions'
  get '/contacts' => 'pages#contacts'
  get '/payment_and_delivery' => 'pages#payment_and_delivery'
  get '/partners' => 'pages#partners'
  resources :products do
    get :who_bought, on: :member
  end

  namespace :admin do
    root to: 'users#index'
    resources :users do
      get :banned_user, on: :member
      get :change_permission, on: :member
    end
    resources :useful_articles
    resources :products
    resources :categories
    resources :shares
  end
end
