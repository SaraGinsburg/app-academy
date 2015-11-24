Links::Application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :links
  resources :comments, only: [:new, :create, :destroy]

end
