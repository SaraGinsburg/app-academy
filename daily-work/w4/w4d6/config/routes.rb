AuthDemo::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end

  resource :home, only: [:show]
  resource :contact, only: [:show]
  resource :about, only: [:show]
end
