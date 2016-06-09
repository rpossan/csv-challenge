Rails.application.routes.draw do
  resources :profiles
  resources :cities
  resources :states
  root to: 'visitors#index'
  devise_for :users
end
