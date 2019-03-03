Rails.application.routes.draw do
  post 'order_items/create',  to: 'order_items#create'
  delete 'order_items/:id',   to: 'order_items#delete'

  resources :locations, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :departments
  resources :orders
  resources :assemblies
  resources :items
end
