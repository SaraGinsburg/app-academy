class AlbumsController < ApplicationController
  before_action :check_login

  def new
    @album = Album.new
    @bands = Band.all

    render :new
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all

    render :edit
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_path(@album)
    else
      render :new
    end
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_path(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    @album.destroy
    redirect_to band_path(band)
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :recording_locale)
  end

end
