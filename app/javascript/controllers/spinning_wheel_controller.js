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
          return `<div class="col-6 col-sm-4 d-flex flex-column align-items-center text-center" style="height: auto; margin-bottom: 0;">
              <div class="rounded-2 border border-custom border-2" style="background: url('${dish[1]}') center/cover no-repeat; width: 80px; height: 80px;"></div>
              <h6 class="pt-2" style="font-size: 18px; font-weight: bold">${dish[0]}</h6>
              <p style="font-family: 'Libre Baskerville'"><span>Rp </span>${dish[2]}.000</p>
          </div>`
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
