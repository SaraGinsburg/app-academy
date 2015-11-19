class SessionsController < ApplicationController
  before_action :require_current_user, only: [:destroy]
  before_action :require_new_user, only:[:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:user_name],
      session_params[:password])
    if user.nil?
      @user = User.new(user_name: session_params[:user_name])
      render :new
    else
      login_user!(user)
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_path
  end

  private

  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
