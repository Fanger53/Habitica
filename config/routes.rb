Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users #, except: [:destroy]
  resources :habits #, only: [:new, :create, :index, :show]
  resources :groups #, only: [:new, :create, :index, :show]
  resources :repeat_days #, only: [:new, :create, :index, :show]

  get '/external_habits', to: 'habits#external_habits'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
end
