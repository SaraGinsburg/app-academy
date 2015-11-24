TweetsApp::Application.routes.draw do
  resources :users, only: [:create, :new, :destroy, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :tweets
  resources :replies, only: [:create, :new, :destroy]

end
