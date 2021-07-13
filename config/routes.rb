Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  get '/host', to: 'pages#host_homepage'

  devise_for :users
  devise_for :hosts
  devise_for :admins

  resources :users
  resources :listings, only: [:show] do
    resources :bookings
  end

  resources :stripes

  # Host
  namespace :host do
    # root 'hosts#show'
  
    resources :dashboards, only: [:show, :edit] do
      get 'pending_bookings'
      get 'confirmed_bookings'
      get 'cancelled_bookings'
    end
    resources :listings do
      member do
        delete :delete_photo_attachment
      end
    end
    resources :bookings
  end

  # Admin
  namespace :admin do
    # root 'hosts#show'
    resources :dashboard
    resources :hosts
    resources :listings
    resources :bookings
  end
end
