import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracking"
export default class extends Controller {
  connect() {
    const cartLabel = document.getElementById("lblCartCount");
    if (cartLabel) {
      cartLabel.remove();
    }
  }
}
