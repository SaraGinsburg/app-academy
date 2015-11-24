class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to link_path(@comment.link_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to link_path(@comment.link_id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to link_path(@comment.link_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :link_id, :body)
  end
end
