class CatsController < ApplicationController

  def index
    @cats = Cat.all

    render :index # Rails magic
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params) # read up on save vs update
      redirect_to cat_path(@cat)
    else
      redirect_to edit_cat_path(@cat)
    end
  end



  private
  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex,
      :description)
  end

end
