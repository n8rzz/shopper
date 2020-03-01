Rails.application.routes.draw do
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'static_pages/index'
  get 'static_pages/after_signup'

  devise_for :users, controllers: {
    invitations: 'users/invitations',
    registrations: 'users/registrations'
  }

  get 'groups/invitation', to: 'groups#invitation'

  resources :groups do
    get 'invitation',    to: 'groups#review_invitation'
    post 'invitation',   to: 'groups#accept_invitation'
    delete 'invitation', to: 'groups#decline_invitation'
  end

  delete 'groups/:id/members/:member_id', to: 'user_groups#delete_member'

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
  resources :meal_schedules

  resources :recipes do
    post '/recipe_ingredient',                           to: 'recipe_ingredients#create'
    put '/recipe_ingredient/:recipe_ingredient_id',      to: 'recipe_ingredients#update'
    delete '/recipe_ingredient/:recipe_ingredient_id',   to: 'recipe_ingredients#destroy'
    post '/recipe_instruction',                          to: 'recipe_instructions#create'
    put '/recipe_instruction/:recipe_instruction_id',    to: 'recipe_instructions#update'
    delete '/recipe_instruction/:recipe_instruction_id', to: 'recipe_instructions#destroy'
  end

  root to: 'orders#index'
end
