Rails.application.routes.draw do

  get 'cars/index'
  get 'cars/show'
  get 'cars/new'
  get 'cars/create'
  get 'cars/edit'
  get 'cars/update'
  get 'cars/destroy'
  root 'pages#home'  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
