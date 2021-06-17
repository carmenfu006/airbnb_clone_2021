Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  get '/platform', to: 'pages#host_homepage'

  devise_for :users
  devise_for :hosts

  resources :users
  resources :hosts
end
