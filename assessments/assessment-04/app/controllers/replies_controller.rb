class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)

    if under_char_limit(@reply.body)
      @reply.save
    end

    redirect_to tweet_path(@reply.tweet_id)
  end

  def destroy
    @reply = Reply.find(params[:id])
    tweet_id = @reply.tweet_id
    @reply.destroy
    redirect_to tweet_path(tweet_id)
  end

  private
  def reply_params
    params.require(:reply).permit(:tweet_id, :body)
  end

end
