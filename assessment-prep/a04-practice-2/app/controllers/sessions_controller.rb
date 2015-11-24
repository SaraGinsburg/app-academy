class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login(@user)
      redirect_to links_path
    else
      flash[:errors] = ["Invalid Username or Password"]
      @user = User.new(username: user_params[:username])
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
