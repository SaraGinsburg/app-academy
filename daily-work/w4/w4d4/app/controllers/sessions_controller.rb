class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      session_params[:email],
      session_params[:password]
    )

    if user
      login_user!(user)
    else
      @user = User.new(email: session_params[:email])
      render :new
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
    params.require(:user).permit(:email, :password)
  end

end
