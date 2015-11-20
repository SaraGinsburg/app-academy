class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.save!
    redirect_to track_path(params[:track_id])
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_path(params[:track_id])
  end


  private
  def note_params
    note_params = params.require(:note).permit(:body)
    note_params[:user_id] = current_user.id
    note_params[:track_id] = params[:track_id]

    note_params
  end
end
