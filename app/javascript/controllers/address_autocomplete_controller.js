import { Controller } from "@hotwired/stimulus";
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String };

  static targets = ["address", "location"];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "address,poi",
      // types: "country,region,place,postcode,locality,neighborhood,address"
    });
    this.geocoder.addTo(this.element);
    this.geocoder.on("result", (event) => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
  }

  #setInputValue(event) {
    console.log(event.result);
    this.addressTarget.value = event.result["place_name"];
    const location = event.result.center;
    const hiddenLongitude = document.getElementById("order_longitude");
    const hiddenLatitude = document.getElementById("order_latitude");
    hiddenLongitude.value = location[0];
    hiddenLatitude.value = location[1];
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }

  disconnect() {
    this.geocoder.onRemove();
  }
}
