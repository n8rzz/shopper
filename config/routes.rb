Rails.application.routes.draw do
  post 'order_items/create'

  resources :departments
  resources :orders
  resources :assemblies
  resources :items
end
