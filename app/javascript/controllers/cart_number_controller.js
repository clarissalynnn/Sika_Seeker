import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart-number"
export default class extends Controller {
  static targets = ["number", "items"]
  connect() {
    console.log('Connected!')
    this.cartItems = [];
  }

  addToCart(event){
    this.cartItems.push(event.target.dataset.itemId);
    this.itemsTarget.value = this.cartItems.join();
    //console.log(event.target.dataset.itemId);
    document.getElementById('lblCartCount').innerHTML = this.cartItems.length;
    console.log(this.cartItems);
  }


}