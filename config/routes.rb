Rails.application.routes.draw do
  root to: 'static_pages#home'
  get '/signup', to: "users#new"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :top
    end
  end
  resources :groups, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :boards, only: [:index, :show, :new, :create]
  resources :posts, only: [:create]
  resources :rooms
  resources :messages, only: [:create]
  resources :posts, only: [:new]
  resources :groups
  resources :notifications, only: [:index, :show]
  resources :user_groups, only: [:update]
  mount ActionCable.server => '/cable'
end
