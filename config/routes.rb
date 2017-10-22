Rails.application.routes.draw do
  resources :line_items do
    put 'decrease_quantity'
    put 'increase_quantity'
  end
  resources :carts
  resources :orders
  resources :products
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"

  get '/products/:id/delete_image', to: 'products#delete_image', as: 'delete_image'

  get '/about' => 'pages#about'
  get '/comments' => 'pages#comments'
  get '/competitions' => 'pages#competitions'
  get '/contacts' => 'pages#contacts'
  get '/payment_and_delivery' => 'pages#payment_and_delivery'
  get '/special_offers' => 'pages#special_offers'
  get '/useful_articles' => 'pages#useful_articles'
  get '/partners' => 'pages#partners'
  resources :products do
    get :who_bought, on: :member
  end
end