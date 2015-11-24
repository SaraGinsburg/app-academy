class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to link_path(@comment.link_id)
  end

  def destroy
    fail
    @comment = Comment.find(comment_params)
    redirect_to link_path(params[:link_id])
  end


  private
  def comment_params
    comment_params = {}
    comment_params[:body] = params[:comment][:body]
    comment_params[:user_id] = current_user.id
    comment_params[:link_id] = params[:link_id]
    comment_params
  end
end
