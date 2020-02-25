Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exhibitions, only: [:show, :index, :new, :create] do
    resources :visits, only: [ :new, :create]
  end
  get '/visits/', to: 'visits#show'

end
