Rails.application.routes.draw do
  root to: 'pages#home'
  get '/partnrs', to: 'pages#partnrs'
  get '/confirmation/:good_id', to: 'pages#confirmation', as: :confirmation
  get '/contract/:good_id', to: 'pages#contract', as: :contract
  devise_for :users
  resources :users, only: :show

namespace :admin do
  resources :goods, except: %i[show index]
end

  resources :goods, only: %i[show index] do
    resources :partners, only: %i[new create]
  end

end
