class CatRentalRequestsController < ApplicationController

  before_action :user_can_process_request, only: [:approve, :deny]

  def create
    @rental_request = CatRentalRequest.new(cat_rental_and_user_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new

    render :new
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end

  def cat_rental_and_user_params
    new_cat_rental_request_params = cat_rental_request_params
    new_cat_rental_request_params[:user_id] = current_user.id
    new_cat_rental_request_params
  end

  def user_can_process_request
    cat_id = CatRentalRequest.find(params[:id]).cat_id
    unless user_owns_cat(cat_id)
      redirect_to cat_path(cat_id)
    end
  end




end
