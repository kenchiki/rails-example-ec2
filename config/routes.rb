Rails.application.routes.draw do
  resources :cart_products
  root 'products#index'

  devise_for :users

  namespace :my do
    resource :user, only: %i[edit update]
  end

  namespace :admin do
    resources :products
  end

  resources :cart_products, only: %i[index]

  resources :products, only: %i[index show] do
    resources :cart_products, only: %i[new create edit update destroy]
  end
end
