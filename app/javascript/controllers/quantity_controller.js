import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="checkout"
export default class extends Controller {
  static targets = ["quantity", "price", "totalprice"];
  static values = {
    orderItemId: Number,
    orderId: Number,
  };

  connect() {
    const quantity = parseInt(this.quantityTarget.value);
    const price = parseInt(this.priceTarget.innerText);
    const totalPrice = quantity * price;

    const totalElement = document.getElementById("total-price");
    totalElement.innerText = parseInt(totalElement.innerText) + totalPrice;

    console.log(totalPrice);

    const cartLabel = document.getElementById("lblCartCount");
    if (cartLabel) {
      cartLabel.remove();
    }
    console.log(this.element);
  }

  increase() {
    console.log("increase clicked");
    const newQuantity = parseInt(this.quantityTarget.value || 0) + 1;
    this.quantityTarget.value = newQuantity;
    const totalPrice = parseInt(this.priceTarget.innerText);
    const currentTotalPrice = parseInt(
      document.getElementById("total-price").innerText
    );
    document.getElementById("total-price").innerText =
      currentTotalPrice + totalPrice;
    this.updateQuantity(
      this.orderIdValue,
      this.orderItemIdValue,
      currentTotalPrice + totalPrice,
      1
    );
  }

  decrease() {
    console.log("decrease clicked");
    const newQuantity = parseInt(this.quantityTarget.value || 0) - 1;
    if (newQuantity == 0) {
      this.element.remove();
    }
    this.quantityTarget.value = newQuantity;
    const totalPrice = parseInt(this.priceTarget.innerText);
    const currentTotalPrice = parseInt(
      document.getElementById("total-price").innerText
    );
    document.getElementById("total-price").innerText =
      currentTotalPrice - totalPrice;
    this.updateQuantity(
      this.orderIdValue,
      this.orderItemIdValue,
      currentTotalPrice - totalPrice,
      -1
    );
    if (newQuantity === 0) {
      this.element.remove();
    }
  }

  destroyOrderItem(event) {
    const orderId = event.target.dataset.orderId;
    const orderItemId = event.target.dataset.orderItemId;
    const url = `/orders/${orderId}/destroy-order-item?order_item_id=${orderItemId}`;
    fetch(url)
      .then(() => {
        const quantity = parseInt(this.quantityTarget.value || 0);
        const totalPrice = parseInt(this.priceTarget.innerText);
        const currentTotalPrice = parseInt(
          document.getElementById("total-price").innerText
        );
        document.getElementById("total-price").innerText =
          currentTotalPrice - quantity * totalPrice;
        this.element.remove();
      })
      .catch((error) => {
        console.error("Error destroying order item:", error);
      });
  }

  updateQuantity(orderId, orderItemId, totalPrice, quantity) {
    const url = `/orders/${orderId}/update-quantity?order_item_id=${orderItemId}&total_price=${totalPrice}&quantity=${quantity}`;
    fetch(url).catch((error) => {
      console.error("Error updating quantity:", error);
    });
  }
}
