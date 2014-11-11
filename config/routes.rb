Rails.application.routes.draw do
  resources :tutorials, only: [:index, :show]
  resources :users, only: [:show]

  root 'pages#home'

  get '/about' => 'pages#about'

  get '/pizza' => 'pizza_votes#index'

  get '/auth/failure'            => 'sessions#failure'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/login'                   => 'sessions#new',     as: :login
  get '/logout'                  => 'sessions#destroy', as: :logout
end
