Rails.application.routes.draw do

  devise_for :users
  root to: 'exhibitions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exhibitions, only: [:show, :index, :new, :create] do
    resources :visits, only: [ :new, :create]
    resources :participations, only: [ :new, :create, :update, :edit, :destroy, :index]
    resources :likes, only: [:new, :create, :destroy, :show]
    member do
      get 'like', to: 'exhibitions#like'
    end
  end
  resources :visits, only: [:show] do
    resources :subscriptions, only: [:create, :new, :update, :edit, :destroy]
    resources :messages, only: :create
  end
  # resources :likes, only: [:index]
  resources :participations, only: [:show]
  resources :likes, only: :index
end
