Rails.application.routes.draw do
  root 'admin/products#index'

  devise_for :users

  namespace :my do
    resource :user, only: %i[edit update]
  end

  namespace :admin do
    resources :products
  end
end
