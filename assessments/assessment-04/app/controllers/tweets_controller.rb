class TweetsController < ApplicationController
  before_action :ensure_login

  def index
    @tweets = Tweet.all
    @my_tweets = @tweets.select {|tweet| tweet.user_id == current_user.id }
  end

  def new
    @tweet = Tweet.new
    render :new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    # fail
    if under_char_limit(@tweet.body)
      if @tweet.save
        render :show
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @tweet = current_tweet
    render :edit
  end

  def update
    @tweet = current_tweet
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet)
    else
      flash[:errors] = @tweet.errors.full_messages
      render :edit
    end
  end

  def show
    @tweet = current_tweet
    @replies = @tweet.replies
    render :show
  end


  private
  def tweet_params
    params.require(:tweet).permit(:title, :body, :user_id)
  end

  def current_tweet
    Tweet.find(params[:id])
  end

end
