class TracksController < ApplicationController
  before_action :check_login

  def new
    @track = Track.new
    @albums = Album.all

    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_path(@track)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all

    render :new
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_path(@track)
    else
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    @notes = @track.notes
    render :show
  end

  def destroy
    @track = Album.find(params[:id])
    album = @track.album
    @track.destroy

    redirect_to album_path(album)
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end

end
