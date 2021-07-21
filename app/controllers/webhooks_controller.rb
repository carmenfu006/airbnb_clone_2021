class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment_success_callback
    charge_id = nil
    event = nil
    endpoint_secret = 'whsec_zaNjkJFVCjgepHT9CdHg4Z1GCE0bLCkt'
    Stripe.api_key = Rails.application.credentials[Rails.env.to_sym][:STRIPE_SK].to_s

    begin
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      payload = request.body.read
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Invalid payload
      return status 400
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      return status 400
    end

    # if event['type'] == 'checkout.session.completed'
    #   checkout_session = event['data']['object']
    #   ref_no = checkout_session['metadata']['ref_no']
    #   booking = Booking.find_by_ref_no(ref_no)
    #   booking.update(status: 'paid', paid_at: Time.zone.now, charge_id: charge_id)
    # else
    #   redirect_to root_path, alert: 'Something went wrong. Please try again.'
    # end

    case event['type']
    when 'charge.succeeded'
      charge_seesion = event['data']['object']
      # charge_id = charge_seesion['id']
      # payment_intent_id = charge_seesion['payment_intent']
      # Charge.create(stripe_charge: charge_id, stripe_payment_intent: payment_intent_id)
    when 'checkout.session.completed'
      checkout_session = event['data']['object']
      ref_no = checkout_session['metadata']['ref_no']
      booking = Booking.find_by_ref_no(ref_no)
      # charge = Charge.find_by_stripe_payment_intent(checkout_session['payment_intent'])
      booking.update(status: 'paid', paid_at: Time.zone.now, charge_id: checkout_session['payment_intent'])
      # charge.update(booking_id: booking.id)
    end
  end
end