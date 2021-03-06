class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !session[:session_token].nil?
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to bands_path
  end

  def check_login
    unless logged_in?
      redirect_to new_session_path
    end
  end
end
