import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart-number"
export default class extends Controller {
  static targets = ["number", "items", "addButton"];

  connect() {
    console.log("Connected!");
    this.cartItems = [];
  }

  addToCart(event) {
    this.cartItems.push(event.target.dataset.itemId);
    this.itemsTarget.value = this.cartItems.join();
    //console.log(event.target.dataset.itemId);
    let button = this.addButtonTarget;
    button.disabled = true;
    button.innerHTML = "Added";
    document.getElementById("lblCartCount").innerHTML = this.cartItems.length;
    console.log(this.cartItems);
  }

  createOrder(event) {
    event.preventDefault();
    console.log("online");
    this.itemsTarget.value = this.cartItems.join();
  }
}
