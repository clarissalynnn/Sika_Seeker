import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "modal", "filter", "content", "items"];

  connect() {
    this.number = Math.ceil(Math.random() * 1000);
    console.log(this.filterTarget.value);
    console.log("Spinning wheel connected");
  }

  spin(event) {
    const csrfToken = document.head.querySelector('[name="csrf-token"]').content;
    fetch(`/pages/wheel?price=${this.filterTarget.value}`, {
      method: "POST",
      headers: {
        accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ price: this.filterTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.itemsTarget.value = data.random_dishes.map((item) => item[3]).join(',')
        const filteredDishes = data.random_dishes.map(dish => {
          return `<div class="col-6 col-sm-4 text-center">
          <div class="rounded-4 d-flex justify-content-center align-items-center border border-custom border-3" style="background: url('${dish[1]}') no-repeat center center; background-size: cover; width: 100%; padding-top: 100%;">
          </div>
          <h5 class="pt-2">${dish[0]}</h5>
          <h5><span>$</span>${dish[2]}</h5>
        </div>`;
        });
        this.contentTarget.innerHTML = filteredDishes.join("")
      });

    // rotating by a randomly generated degree
    this.containerTarget.style.transform = "rotate(" + this.number + "deg)"
    this.number += Math.ceil(Math.random() * 1000)

    const spinDuration = 3500;
    this.customModal = new bootstrap.Modal(this.modalTarget);
    setTimeout(() => {
      this.customModal.show();
    }, spinDuration);
  }
}
