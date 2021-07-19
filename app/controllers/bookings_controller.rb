class BookingsController < UsersController
  def show
    @booking = Booking.find(params[:id])
  end

  def create
    listing = Listing.find(params[:listing_id])
    booking = listing.bookings.create(booking_params.merge(user_id: current_user.id))

    if booking.save
      redirect_to listing_booking_path(listing, booking), notice: 'Booking was successfully created.'
    else
      redirect_to listing_path(listing), alert: 'There was an error. Please try again.'
    end
  end

  def payment_details
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.find(params[:booking_id])
  end

  def success
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.find(params[:booking_id])
  end

  def cancel
  end

  private
    def booking_params
      params.require(:booking).permit(:ref_no, :check_in_date, :check_out_date, :status, :total)
    end
end