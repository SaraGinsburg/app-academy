Links::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :links
  resources :comments, only: [:create, :destroy]
end
