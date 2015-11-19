class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new

    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_request_params)
    if @request.save
      redirect_to cats_url # look at kitties bc we don't gaf about a requests index page
    else
      render :new
    end
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date,
      :end_date)
  end
end
