Rails.application.routes.draw do
  resources :cart_products
  root 'products#index'

  devise_for :users

  namespace :my do
    resource :user, only: %i[edit update]
  end

  namespace :admin do
    resources :products do
      member do
        put :sort_up, :sort_down, :sort_top, :sort_bottom
      end
    end
    resource :tax, only: %i[new create]
    resource :delivery_price, only: %i[new create]
    resource :cash_on_delivery, only: %i[new create]
    resources :users, only: %i[index show edit update destroy]
  end

  resources :cart_products, only: %i[index]

  resources :products, only: %i[index] do
    resources :cart_products, only: %i[new create edit update destroy]
  end
end
