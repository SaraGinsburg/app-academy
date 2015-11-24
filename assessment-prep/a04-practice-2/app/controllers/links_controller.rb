class LinksController < ApplicationController
  before_action :ensure_login

  def index
    @links = Link.all
    render :index
  end

  def new
    @link = Link.new
    render :new
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def edit
    @link = current_link
    render :edit
  end

  def update
    @link = Link.find(params[:id])

    if @link.update(link_params)
      redirect_to link_path(@link)
    else
      flash[:errors]= @link.errors.full_messages
      render :edit
    end
  end

  def show
    @link = current_link
    @comments = @link.comments
    render :show
  end


  private
  def link_params
    params.require(:link).permit(:user_id, :title, :url)
  end

  def current_link
    Link.find(params[:id])
  end
end
