class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :log_in!, :log_out!, :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to links_path
  end

  def log_out!
    session[:session_token] = nil
  end

  def logged_in?
    !session[:session_token].nil?
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
