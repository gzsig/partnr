Rails.application.routes.draw do

  get 'landing', to: 'pages#landing'
  root 'pages#home'
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
