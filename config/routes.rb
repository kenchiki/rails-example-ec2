Rails.application.routes.draw do
  root 'products#index'

  devise_for :users

  namespace :my do
    resource :user, only: %i[edit update]
  end

  namespace :admin do
    resources :products
  end

  resources :products, only: %i[index show]
end
