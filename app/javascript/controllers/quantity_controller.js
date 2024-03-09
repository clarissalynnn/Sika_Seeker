import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkout"
export default class extends Controller {
  static targets = ["quantity", "price", "totalprice"]
  connect() {
    console.log('Connected!')
    const totalPrice = parseInt(this.quantityTarget.value) * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = totalPrice + parseInt(document.getElementById("total-price").innerHTML);
    console.log(totalPrice);
    document.getElementById("lblCartCount").remove();
  }

  increase() {
    console.log("increase clicked");
    // debugger;
    const newQuantity = parseInt(this.quantityTarget.value || 0) + 1;
    this.quantityTarget.value = newQuantity;
    const totalPrice = 1 * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = totalPrice + parseInt(document.getElementById("total-price").innerText);
  }

  decrease() {
    console.log("decrease clicked");
    const newQuantity = parseInt(this.quantityTarget.value || 0) - 1;
    this.quantityTarget.value = newQuantity;
    const totalPrice = 1 * parseInt(this.priceTarget.innerText);
    document.getElementById("total-price").innerText = parseInt(document.getElementById("total-price").innerText) - totalPrice;
  }
}
