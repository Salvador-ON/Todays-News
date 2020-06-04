Rails.application.routes.draw do
  get '/', to: 'pages#home'
  root 'pages#home'
end
