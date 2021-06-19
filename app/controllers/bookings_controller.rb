class BookingsController < UsersController
  def show
    @booking = Booking.find(params[:id])
    @stripePK = 'pk_test_51IVIRmEjXwEYMjCUE2U0RGz3A2ZcfqH0PIE8vCYkbrRjx5FmmcjNyRA5wj97ziJ66dGnA7FEhMlNMnrSWodhVXRr00T02rU2ny'
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

  private
    def booking_params
      params.require(:booking).permit(:ref_no, :check_in_date, :check_out_date, :status, :total)
    end
end