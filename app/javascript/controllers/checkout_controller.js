import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkout"
export default class extends Controller {
  connect() {
    const cartLabel = document.getElementById("lblCartCount");
    if (cartLabel) {
      cartLabel.remove();
    }
  }
}
