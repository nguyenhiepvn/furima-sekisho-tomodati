Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
  
  root "items#index"
  get 'items/new', to: 'items#new' 
  post 'items/new', to: 'items#create'

  resources :users  
  resources :items do
    resources :orders, only: [:index, :create, :new]
    resources :cards, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
    
    collection do
      get 'search'
    end
  end
end
