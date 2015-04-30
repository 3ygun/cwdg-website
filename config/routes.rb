Rails.application.routes.draw do
  resources :tutorials, only: [:index, :show], path: "blog" do
    collection do
      post 'event_handler'
    end
  end
  resources :users, only: [:show]

  root 'pages#home'

  get '/about' => 'pages#about'

  get '/auth/failure'            => 'sessions#failure'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/login'                   => 'sessions#new',     as: :login
  get '/logout'                  => 'sessions#destroy', as: :logout
end
