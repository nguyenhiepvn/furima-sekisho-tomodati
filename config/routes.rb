Rails.application.routes.draw do
  root "items#index"
  get 'items/new', to: 'items#new' 
  post 'items/new', to: 'items#create'
end
