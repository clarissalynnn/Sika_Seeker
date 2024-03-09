import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkout"
export default class extends Controller {
  static targets = ["quantity", "price", "totalprice"];
  static values = {
    orderItemId: Number,
    orderId: Number
  }

  connect() {
    console.log('Connected!')
    const totalPrice = parseInt(this.quantityTarget.value) * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = totalPrice + parseInt(document.getElementById("total-price").innerHTML);
    console.log(totalPrice);

    const cartLabel = document.getElementById("lblCartCount");
    if (cartLabel) {
      cartLabel.remove();
    }
  }

  increase() {
    console.log("increase clicked");
    console.log(this.orderItemIdValue);
    console.log(this.orderIdValue);
    // debugger;
    const newQuantity = parseInt(this.quantityTarget.value || 0) + 1;
    this.quantityTarget.value = newQuantity;
    const totalPrice = 1 * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = totalPrice + parseInt(document.getElementById("total-price").innerText);
    this.updateQuantity(this.orderIdValue, this.orderItemIdValue, document.getElementById("total-price").innerText);
  }

  decrease() {
    console.log("decrease clicked");
    const newQuantity = parseInt(this.quantityTarget.value || 0) - 1;
    this.quantityTarget.value = newQuantity;
    const totalPrice = 1 * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = parseInt(document.getElementById("total-price").innerText) - totalPrice;
  }

  updateQuantity(orderId, orderItemId, totalPrice) {
    const url = `/orders/${orderId}/update-quantity?order_item_id=${orderItemId}&total_price=${totalPrice}`;
    fetch(url);
  }
}
