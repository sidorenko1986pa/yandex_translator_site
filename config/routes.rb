Rails.application.routes.draw do
  root 'pages#main'
  post 'pages/translation'

  resource :user_sessions, only: [:create]
  get '/login', to: 'user_sessions#new'
  delete '/logout', to: 'user_sessions#destroy'

  resource :users, only: [:create]
  get '/signup', to: 'users#new'

end
