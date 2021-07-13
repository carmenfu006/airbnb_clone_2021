Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  get '/platform', to: 'pages#host_homepage'

  devise_for :users
  devise_for :hosts

  resources :users
  resources :listings, only: [:show] do
    resources :bookings
  end

  resources :stripes

  namespace :dashboard do
    # root 'hosts#show'
  
    resources :hosts, only: [:show, :edit, :update]
    resources :listings do
      member do
        delete :delete_photo_attachment
      end
    end
  end
end
