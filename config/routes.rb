Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: "home#index"
  get 'location', to:'locations#list' , as: 'list_locations'
  get 'other_location', to:'locations#list_other' , as: 'list_other_locations'
  get 'new_location', to:'locations#new', as: 'new_location'
  post 'locations', to: 'locations#create'
  get 'delete_location', to:'locations#destroy', as: 'delete_location'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
