Rails.application.routes.draw do
  root 'my/users#edit'
  devise_for :users
  namespace :my do
    resource :user
  end
end
