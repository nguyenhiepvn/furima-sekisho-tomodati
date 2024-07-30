Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
  
  root "items#index"
  get 'items/new', to: 'items#new' 
  post 'items/new', to: 'items#create'
  resources :users
  resources :items
  get 'orders/new', to: 'orders#index'
  post 'orders/new', to: 'orders#create'
  resources :orders, only: [:new, :create]
end
