Rails.configuration.stripe = {
  :publishable_key => 'sk_test_2JVr248Tt2Y5uFX957qUVel6',
  :secret_key      => 'pk_test_qLD4b80YRV3WGvKF2N3s3kPM'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
