Rails.application.routes.draw do
 

  get '/welcome', to: 'pages#home'
  root 'pages#home'
end
