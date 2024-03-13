class PaymentsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_total_in_cents = (@order.total_price * 100000).to_i  # Convert total price to cents
    @order_total_in_cents = [50, @order_total_in_cents].max  # Ensure minimum total amount
    Rails.logger.info "Order total in cents: #{@order_total_in_cents}"
    @checkout_session_id = create_checkout_session(@order, @order_total_in_cents)
  end

  def create
    # Get the order and calculate the total price
    @order = Order.find(params[:order_id])
    @order_total = @order.total_price

    # Create a Stripe Checkout session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          name: "Order ##{@order.id}",
          amount: @order_total * 100,
          currency: 'idr',
          quantity: 1
        }
      ],
      success_url: success_payment_url(order_id: @order.id), # Redirect URL after successful payment
      cancel_url: cancel_payment_url # Redirect URL if payment is canceled
    )

    redirect_to session.url, notice: 'Redirecting to payment page...'
  end

  def success
    @order = Order.find(params[:order_id])
    @order.update(status: :in_progress)
    redirect_to order_track_path, notice: 'Payment successful!'
  end

  def cancel
    redirect_to new_payment_path, alert: 'Payment canceled!'
  end

  private

  def create_checkout_session(order, total_price_in_cents)
    price = Stripe::Price.create({
      unit_amount: total_price_in_cents,
      currency: 'idr',
      product_data: {
        name: "Order ##{order.id}"
      }
    })

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: price.id,
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_payment_url(order_id: order.id),
      cancel_url: cancel_payment_url
    )

    session.id
  end
end
