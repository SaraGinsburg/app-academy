class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login(@user)
      redirect_to tweets_path
    else
      @user = User.new(username: user_params[:username])
      flash[:errors] = ["Invalid Username or Password"]
      render :new
    end

  end

  def destroy
    logout
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
