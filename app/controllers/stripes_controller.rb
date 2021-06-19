class StripesController < UsersController
  protect_from_forgery with: :null_session

  def create
    Stripe.api_key = Rails.application.credentials[Rails.env.to_sym][:STRIPE_SK].to_s

    booking = Booking.find(params[:id])

    token = params[:stripeToken]

    charge = Stripe::Charge.create({
      amount: booking.total.to_i * 100,
      currency: 'myr',
      description: 'Example charge',
      source: token,
      metadata: {
        ref_no: booking.ref_no
      }
    })

    if charge.paid == true
      booking.update(status: 'paid', paid_at: Time.zone.now, charge_id: charge.id)
      redirect_to stripe_path(booking.charge_id), notice: 'Payment was successfully created.'
    else
      redirect_to listing_booking_path(booking.listing, booking), alert: 'There was an error. Please try again.'
    end
  end

  def show
    charge_id = params[:id]

    @charge = Stripe::Charge.retrieve(
                charge_id,
              )
  end
end