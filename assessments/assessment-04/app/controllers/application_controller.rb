class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :login, :logout, :logged_in?,
    :ensure_login, :under_char_limit

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
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

  def under_char_limit(body)
    unless body.length <= 140
      flash[:errors] = ["Body is too long"]
      false
    end
    true
  end
end
