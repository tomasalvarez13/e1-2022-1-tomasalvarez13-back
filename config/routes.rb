# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  # devise_for :users
  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
    }
  end

  root to: 'home#index'
  get 'location', to: 'locations#list', as: 'list_locations' # #READY
  get 'other_location', to: 'locations#list_other', as: 'list_other_locations' # #READY
  get 'new_location', to: 'locations#new', as: 'new_location' # READY
  post 'locations', to: 'locations#create' # READY
  delete 'delete_location', to: 'locations#destroy', as: 'delete_location'
  get 'all_users', to: 'locations#all_users', as: 'all_users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
