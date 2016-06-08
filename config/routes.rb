Rails.application.routes.draw do
  resources :states
  root to: 'visitors#index'
  devise_for :users
end
