class PaymentsController < ApplicationController
  def new
  end

  def create
    # Get the payment token ID submitted by the form:
    token = params[:stripeToken]

    # Create a payment:
    payment = Stripe::Payment.create(
      amount: 1000, # Amount in cents
      currency: 'idr',
      description: 'Order #{order.id}',
      source: token
    )

    redirect_to order_track_path, notice: 'Payment successful!'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
