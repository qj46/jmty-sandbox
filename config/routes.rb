# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/index'

  resources :posts, only: %i[create new]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'appearance', to: 'dashboard#appearance'
  get ':id', to: 'dashboard#show', as: :user
  get 'posts/:id', to: 'posts#show', as: :post
  delete 'posts/:id', to: 'posts#destroy'
end
