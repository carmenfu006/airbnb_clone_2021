class StripesController < UsersController
  protect_from_forgery with: :null_session

  def create
    Stripe.api_key = Rails.application.credentials[Rails.env.to_sym][:STRIPE_SK].to_s

    domain = 'http://localhost:3000'

    booking = Booking.find(params[:id])

    session = Stripe::Checkout::Session.create({
                payment_method_types: ['card'],
                line_items: [{
                  price_data: {
                    unit_amount: booking.total.to_i * 100,
                    currency: 'usd',
                    product_data: {
                      name: booking.listing.title,
                      images: [url_for(booking.listing.photos.first)],
                    },
                  },
                  quantity: 1,
                }],
                mode: 'payment',
                metadata: {
                  ref_no: booking.ref_no
                },
                success_url: domain + listing_booking_success_path(booking.listing, booking),
                cancel_url: domain + listing_booking_cancel_path(booking.listing, booking),
              })

              redirect_to session.url
  end
end