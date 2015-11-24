class LinksController < ApplicationController
  def new
    # fail
    if logged_in?
      @link = Link.new
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id

    if @link.save
      redirect_to link_path(@link)
    else
      render :new
    end
  end

  def edit
    if logged_in?
      @link = Link.find(params[:id])
      render :edit
    else
      redirect_to new_session_url
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to link_path(@link)
    else
      # @link = Link.new(link_params)
      render :edit
    end
  end

  def index
    if logged_in?
      @links = Link.all
      render :index
    else
      redirect_to new_session_url
    end
  end

  def show
    @link = Link.find(params[:id])
    # @comment = nil
    render :show
  end


  private
  def link_params
    params.require(:link).permit(:url, :title)
  end
end
