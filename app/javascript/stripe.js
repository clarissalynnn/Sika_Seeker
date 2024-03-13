// JavaScript code to handle Stripe.js functionality
document.addEventListener("DOMContentLoaded", function() {
  var stripe = Stripe('<%= Rails.configuration.stripe[:publishable_key] %>');
  var elements = stripe.elements();

  var card = elements.create('card');
  card.mount('#card-element');

  card.on('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });

  var form = document.getElementById('payment-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault();
    stripe.createToken(card).then(function(result) {
      if (result.error) {
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        stripeTokenHandler(result.token);
      }
    });
  });

  function stripeTokenHandler(token) {
    // Simulate sending the token to your server and processing the payment
    setTimeout(function() {
      // Simulate a successful payment
      alert('Payment successful!');

      // Redirect to a success page or update UI
      window.location.href = '/orders/success';
    }, 1000); // Simulate a delay to mimic server processing time
  }

});
