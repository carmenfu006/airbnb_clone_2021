class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment_success_callback
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

    if event['type'] == 'checkout.session.completed'
      checkout_session = event['data']['object']
      ref_no = checkout_session['metadata']['ref_no']
      booking = Booking.find_by_ref_no(ref_no)
      booking.update(status: 'paid', paid_at: Time.zone.now, charge_id: checkout_session['payment_intent'])
    else
      redirect_to root_path, alert: 'Something went wrong. Please try again.'
    end
  end
end