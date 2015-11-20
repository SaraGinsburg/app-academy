Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: :new
  end

  resources :tracks, except: [:index, :new] do
    resources :notes, only: [:new, :create, :destroy]
  end
  resources :notes, except: [:new, :create, :destroy]

end
