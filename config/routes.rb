Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resource :users, only: :show

  resources :goods do
    resources :partners, only: %i[new create]
  end
end
