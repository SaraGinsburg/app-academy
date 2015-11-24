class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login, :logout, :logged_in?,
    :ensure_login


  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_sesion_token!
  end

  def logout
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def ensure_login
    redirect_to new_session_path unless logged_in?
  end

end
