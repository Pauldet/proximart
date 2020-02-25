Rails.application.routes.draw do
  get 'visits/index'
  get 'visits/show'
  get 'visits/create'
  get 'visits/new'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exhibitions, only: [:show, :index, :new, :create]

end
