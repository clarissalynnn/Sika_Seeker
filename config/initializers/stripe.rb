Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}

ENV['STRIPE_PUBLISHABLE_KEY'] = 'pk_test_51OtONtFVQds6mEOJ65ZY5ZBowSQEO0TqfR58sE0SpTAcmiM8GzO8DQoPqBZyhQqTTTEFWI1avjuZdfXn8gN9Vo2f006SDvTIG8'
ENV['STRIPE_SECRET_KEY'] = 'sk_test_51OtONtFVQds6mEOJ8v0ArtB4HQeAH4hfnJ1drbLsfzcbsufb29QUkoIG6BaIjqM1RWrxWmgSHnaGGkXstk5YnwTN008iuPw24E'

Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.logger.info "Stripe Publishable Key: #{Rails.configuration.stripe[:publishable_key]}"
Rails.logger.info "Stripe Secret Key: #{Rails.configuration.stripe[:secret_key]}"
