Rails.application.routes.draw do
  devise_for :attendees
  devise_for :users
  root to: 'home#index'
  resources :workshops, only: [ :new, :create, :show ]
end
