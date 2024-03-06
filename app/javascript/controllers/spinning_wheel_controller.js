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

  spin() {
    fetch(this.filterTarget.action,
    { method: 'GET',
      headers: { accept: "application/json", "Content-Type": "application/json" },
      body: JSON.stringify(this.filterTarget.value)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })



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
