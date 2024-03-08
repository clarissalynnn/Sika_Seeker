import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-menu"
export default class extends Controller {
  static targets = ["form", "input", "list"];

  connect() {}

  update(event) {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    fetch(url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
      });
    this.listTarget.classList.remove("d-none");
    if (this.inputTarget.value === "") {
      this.listTarget.classList.add("d-none");
    }
  }

  clear() {
    this.inputTarget.value = "";
  }
}
