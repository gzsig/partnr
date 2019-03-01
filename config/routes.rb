Rails.application.routes.draw do
  root to: 'pages#home'
  get '/partnrs', to: 'pages#partnrs'
  devise_for :users
  resource :users, only: :show

  resources :goods do
    resources :partners, only: %i[new create]
  end

end
