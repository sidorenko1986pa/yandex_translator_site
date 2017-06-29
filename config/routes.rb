Rails.application.routes.draw do
  root 'pages#main'
  post 'pages/translation'
end
