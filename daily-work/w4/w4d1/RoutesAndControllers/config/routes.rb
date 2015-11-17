Rails.application.routes.draw do
  resources :users, only: [:index, :create, :update, :destroy, :show] do
    resources :contacts, only: [:index]
  end
  resources :contacts, only: [ :create, :update, :destroy, :show]
  resources :contact_shares, only: [:create, :destroy]
  # get 'users' => 'users#index'
  # post 'users' => 'users#create'
  # get 'users/new' => 'users#new'
  # get 'users/:id/edit' => 'users#edit'
  # get 'users/:id' => 'users#show'
  # patch 'users/:id' => 'users#update'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'
end
