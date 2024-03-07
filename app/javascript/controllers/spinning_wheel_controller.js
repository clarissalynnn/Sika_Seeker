import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinning-wheel"
export default class extends Controller {
  static targets = ["container", "modal", "filter"]

  connect() {
    // random starting position for the rotation
    this.number = Math.ceil(Math.random() * 1000)
    console.log(this.filterTarget.value)
    console.log("Spinning wheel connected")
  }

  spin(event) {
    const csrfToken = document.head.querySelector('[name="csrf-token"]').content;
    fetch(`/pages/wheel?price=${this.filterTarget.value}`,
    {
      method: "POST",
      headers: { accept: "application/json", "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken },
      body: JSON.stringify({price: this.filterTarget.value})
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)

      const filteredDishes = data.random_dishes.map(dish => {
        return `<div class="col-6 col-sm-4 text-center">
          <div class="rounded-4 d-flex justify-content-center align-items-center border border-custom border-3" style="background: url('${dish[1]}') no-repeat center center; background-size: cover; width: 100%; padding-top: 100%;">
          </div>
          <h5>${dish[0]}</h5>
          <h5>Rp${dish[2]}</h5>
        </div>`
      })

      this.modalTarget.innerHTML = `
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content p-3 rounded-3">
            <div class="modal-header">
              <h1 class="modal-title fs-5 text-center" id="exampleModalLabel"><strong> You're getting...</strong></h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="row gx-5 gy-5">
              ${filteredDishes.join("")}
              </div>
            </div>
            <div class="modal-footer d-flex justify-content-around">
              <button type="button" class="btn btn-custom flex-grow-1 m-1" data-bs-dismiss="modal">Spin Again</button>
              <button type="button" class="btn btn-custom flex-grow-1 m-1">Go to Menu</button>
              <button type="button" class="btn btn-custom flex-grow-1 m-1">Check Out</button>
            </div>
          </div>
        </div>
      </div> `
      });

    // rotating by a randomly generated degree
    this.containerTarget.style.transform = "rotate(" + this.number + "deg)"
    this.number += Math.ceil(Math.random() * 1000)

    // CSS transition => 3s + 0.5 buffer
    const spinDuration = 3500;

    // show modal after 3.5s
    setTimeout(() => {
      this.customModal = new bootstrap.Modal(this.modalTarget)
      this.customModal.show()
    }, spinDuration)

  }
}


// show min and max amount on the slider
// apply price options to random dishes
