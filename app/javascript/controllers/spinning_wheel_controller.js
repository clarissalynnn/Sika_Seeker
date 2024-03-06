import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinning-wheel"
export default class extends Controller {
  static targets = ["container", "modal"]

  connect() {
    // random starting position for the rotation
    this.number = Math.ceil(Math.random() * 1000)
    console.log("Spinning wheel connected")
  }

  spin() {
    // rotating by a randomly generated degree
    this.containerTarget.style.transform = "rotate(" + this.number + "deg)"
    this.number += Math.ceil(Math.random() * 1000)

    // CSS transition => 3s
    const spinDuration = 3500;

    // show modal after 3s
    setTimeout(() => {
      this.customModal = new bootstrap.Modal(this.modalTarget)
      this.customModal.show()
    }, spinDuration)
  }
}


// show min and max amount on the slider
// apply price options and to random dishes
