class StripesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    Stripe.api_key = 'sk_test_51IVIRmEjXwEYMjCUA12j8iJRJabUzCCtIZuhPdjxadanWgDIMsSoq9Z81DpSHdqtnAGQbkfM5BBjcdhrXL3W2kt700QeSFAAd8'

    booking = Booking.find(params[:id])

    token = params[:stripeToken]

    charge = Stripe::Charge.create({
      amount: params[:amount].to_i * 100,
      currency: 'myr',
      description: 'Example charge',
      source: token,
    })

    if charge.paid == true
      booking.update(status: 'paid', paid_at: Time.zone.now, charge_id: charge.id)
      redirect_to user_path(booking.user), notice: 'Payment was successfully created.'
    else
      redirect_to listing_booking_path(booking.listing, booking), alert: 'There was an error. Please try again.'
    end
  end
end