Rails.application.routes.draw do
  root to: 'pages#home'
  get '/partnrs', to: 'pages#partnrs'
  devise_for :users
  resource :users, only: :show

namespace :admin do
  resources :goods, except: %i[show index]
end

  resources :goods, only: %i[show index] do
    resources :partners, only: %i[new create]
  end

end
