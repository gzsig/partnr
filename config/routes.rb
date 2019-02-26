Rails.application.routes.draw do

  root 'pages#home'
  devise_for :users
  resources :users, except: :index

  namespace :admin do
    resources :users
    resources :partners, only: %i[index]
  end

  resources :goods do
    resources :partners, only: %i[new create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
