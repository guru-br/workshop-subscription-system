# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :attendees
  devise_for :users
  root to: 'home#index'
  resources :workshops, only: %i[index new create show edit index update] do
    resource :enrollment, only: :destroy
  end

  resources :enrollments, only: [] do
    post :waiting_list_create, to: 'enrollments#waiting_list_create', as: 'waiting_list', on: :collection
  end
end
