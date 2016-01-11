class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def index
    @tags = Tag.all
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    
    flash.notice = "You deleted the tag \"#{@tag.name}\"!"
    
    @tag.destroy
    redirect_to tags_path
  end
end
