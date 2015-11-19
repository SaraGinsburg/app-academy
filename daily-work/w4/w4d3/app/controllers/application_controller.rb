class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_owns_cat, :user_can_modify_cat

  def require_new_user
    redirect_to cats_path if current_user
  end

  def require_current_user
    redirect_to new_session_url if current_user.nil?
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to cats_path
  end


  def user_can_modify_cat
    unless user_owns_cat
      redirect_to cats_url
    end
  end

  def user_owns_cat(cat_id = params[:id].to_i)
    return false unless current_user
    current_user.cats.pluck(:id).include?(cat_id)
  end





end
