import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinning-wheel"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    // random starting position for the rotation
    this.number = Math.ceil(Math.random() * 1000)
    console.log("Spinning wheel connected")
  }

  spin() {
    // rotating by a randomly generated degree
    this.containerTarget.style.transform = "rotate(" + this.number + "deg)"
    this.number += Math.ceil(Math.random() * 1000)
  }
}
