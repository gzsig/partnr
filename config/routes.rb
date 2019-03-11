Rails.application.routes.draw do
  devise_for :users
  get '/partnrs', to: 'pages#partnrs'
  get '/confirmation/:good_id', to: 'pages#confirmation', as: :confirmation
  get '/contract/:good_id', to: 'pages#contract', as: :contract
  resources :users, only: :show

  namespace :admin do
    resources :goods, except: %i[show index]
  end

  resources :partners, only: :destroy
  resources :goods, only: %i[show index] do
    resources :partners, only: %i[ create ]
  end
  root to: 'goods#index'

end
