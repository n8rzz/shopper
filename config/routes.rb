Rails.application.routes.draw do
  post 'order_items/create',          to: 'order_items#create'
  patch 'order_items/:id',            to: 'order_items#update'
  put 'order_items/:id',              to: 'order_items#update'
  delete 'order_items/:id',           to: 'order_items#delete'
  post 'order_items/create/item',     to: 'order_items#create_item'
  post 'order_items/create/assembly', to: 'order_items#create_assembly'

  resources :locations, except: [:show]
  resources :departments
  resources :orders do
    # TODO: use nested resources for routes declared above
    # resources :order_items

    post '/duplicate', to: 'orders#duplicate'
    delete '/assembly/:assembly_id', to: 'orders#delete_assembly', as: 'assembly'
  end
  resources :assemblies, except: [:show]
  resources :items, except: [:show]
  resources :location_departments, only: [:create, :update, :destroy]
  post 'location_departments/:id/:direction', to: 'location_departments#change_direction'

  root to: 'orders#index'
end
