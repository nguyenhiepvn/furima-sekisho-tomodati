Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
  
  root "items#index"
  get 'items/new', to: 'items#new' 
  post 'items/new', to: 'items#create'
  get 'item/show/id', to:'item#show'
  resources :users
  resources :items
    
end
