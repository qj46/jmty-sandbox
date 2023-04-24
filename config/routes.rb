# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/index'
  get 'lists', to: 'lists#index'

  resources :rooms, only: %i[create index show]
  resources :messages, only: [:create]

  # resources :posts, only: [:create, :new]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'appearance', to: 'dashboard#appearance'
  get ':id', to: 'dashboard#show', as: :user

  resources :posts do
    resource :likes
  end
end
