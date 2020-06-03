Rails.application.routes.draw do
 

  get '/welcome', to: 'pages#home'
  get '/news', to: 'pages#news'
  root 'pages#home'
end
