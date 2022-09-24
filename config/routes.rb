# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'about', to:
    'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  get 'users/signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  namespace :api, defaults: {format: :json } do
    namespace :v1 do
      resources :articles
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
