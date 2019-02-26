Rails.application.routes.draw do

  root 'pages#home'
  devise_for :users
  resource :users, only: :show

  resources :goods do
    resources :partners, only: %i[new create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
