import { Controller } from "@hotwired/stimulus";

import driving_steps from "./driving_steps.json" assert { type: "json" };

// Connects to data-controller="track-map"
export default class extends Controller {
  static values = {
    apiKey: String,
    orderMarker: Object,
    isDriver: Boolean
  };

  connect() {
    console.log("track-map connected...");
    // console.log(this.apiKeyValue);
    // console.log(this.orderMarkerValue);

    const cartLabel = document.getElementById("lblCartCount");
    if (cartLabel) {
      cartLabel.remove();
    }

    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });

    this.fromLocation = [115.1295623, -8.6508524]; // Warung Sika's location
    this.toLocation = [this.orderMarkerValue.lng, this.orderMarkerValue.lat];

    this.from = turf.featureCollection([turf.point(this.fromLocation)]);
    this.to = turf.featureCollection([turf.point(this.toLocation)]);

    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    this.#addRoute();
    this.#addRoute();

    // this.displayDrivingDirections();
  }

  displayDrivingDirections(steps) {
    const drivingDiv = document.getElementById("directions");
    drivingDiv.innerHTML = `<p>Distance to destination: <strong>${Math.floor(steps[1].distance)}m</strong></p>`;
    const timeDiv = document.getElementById("time");
    timeDiv.innerHTML = `<p>Order preparation: <strong>${Math.floor(steps[0].duration)}min</strong></p><p>Trip duration: <strong>${Math.floor(
      steps[1].distance / 60
      )} min 🛵 </strong></p>`;
    // get the sidebar and add the instructions
    const instructions = document.getElementById('instructions');

    let tripInstructions = '';
      for (const step of steps) {
      tripInstructions += `<li>In <strong>${Math.floor(step.maneuver.bearing_after)}m </strong> ${step.maneuver.instruction}</li>`;
      }
      instructions.innerHTML = `<ol>${tripInstructions}</ol>`;

    // array index
    // const YEARS = 0
    // const MONTHS = 1
    const DAYS = 2
    const HOURS = 3
    const MINUTES = 4
    // test time interval
    function addInterval(date, interval) {
      const parts = [
        date.getFullYear(),
        date.getMonth(),
        date.getDate(),
        date.getHours(),
        date.getMinutes(),
        date.getSeconds(),
        date.getMilliseconds()
      ]
      // fetch keys/values
      for (const [unit, value] of Object.entries(interval)) {
          parts[unit] += value
      }

      return new Date(...parts)
    }
    const now = new Date();
    let future = addInterval(now, {
      [HOURS]: 0,
      [MINUTES]: 30
    })
    console.log(now)
    console.log(future)

    const intervalDiv = document.getElementById("interval");
    if (intervalDiv) {
      const formatter = new Intl.DateTimeFormat('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
      const formattedTime = formatter.format(future);
      intervalDiv.innerHTML = `<p>*Estimated delivery time at <strong> ${formattedTime} </strong></p>`;
    }

  }

  #addMarkersToMap() {
    // Order Marker
    const orderPopup = new mapboxgl.Popup().setHTML(
      this.orderMarkerValue.info_window_html
    );
    new mapboxgl.Marker()
      .setLngLat([this.orderMarkerValue.lng, this.orderMarkerValue.lat])
      .setPopup(orderPopup)
      .addTo(this.map);

    // Warung Sika Marker
    const sikaPopup = new mapboxgl.Popup().setHTML(
      `<h2>Warung Sika</h2>
      <button class="mapboxgl-popup-close-button" type="button" aria-label="Close popup" aria-hidden="true">×</button>`
    );
    new mapboxgl.Marker()
      .setLngLat([115.1295623, -8.6508524])
      .setPopup(sikaPopup)
      .addTo(this.map);
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([this.orderMarkerValue.lng, this.orderMarkerValue.lat]);
    bounds.extend([115.1295623, -8.6508524]); // Extend bounds to Warung Sika as well

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  #addRoute() {
    fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${this.fromLocation.join(
        ","
      )};${this.toLocation.join(
        ","
      )}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`,
      { method: "GET" }
    )
      .then((response) => response.json())
      .then((data) => {
        console.log(data);

        this.displayDrivingDirections(data.routes[0].legs[0].steps);

        let coordinates = data.routes[0].geometry.coordinates;
        // console.log(coordinates);
        const len = coordinates.length;
        const distributions = [1, 2];
        if (len > 12) {
          coordinates.splice(1, coordinates.length - 12);
        }
        // console.log(coordinates);

        fetch(
          `https://api.mapbox.com/optimized-trips/v1/mapbox/driving/${coordinates.join(
            ";"
          )}?distributions=${distributions}&overview=full&steps=true&geometries=geojson&roundtrip=false&source=first&destination=last&access_token=${
            mapboxgl.accessToken
          }`,
          { method: "GET" }
        )
          .then((response) => response.json())
          .then((data2) => {
            console.log(data2);
            const nothing = turf.featureCollection([]);

            const routeGeoJSON = turf.featureCollection([
              turf.feature(data2.trips[0].geometry),
            ]);
            // debugger;

            if (this.map.getSource("route")) {
              this.map.getSource("route").setData(routeGeoJSON);
            } else {
              this.map.addSource("route", {
                type: "geojson",
                data: nothing,
              });

              this.map.addLayer(
                {
                  id: "routeline-active",
                  type: "line",
                  source: "route",
                  layout: {
                    "line-join": "round",
                    "line-cap": "round",
                  },
                  paint: {
                    "line-color": "green",
                    "line-width": [
                      "interpolate",
                      ["linear"],
                      ["zoom"],
                      12,
                      3,
                      22,
                      12,
                    ],
                  },
                },
                "waterway-label"
              );
            }
          });
      });
  }
}
