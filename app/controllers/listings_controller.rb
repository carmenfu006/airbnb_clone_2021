class ListingsController < UsersController
  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
  end
end