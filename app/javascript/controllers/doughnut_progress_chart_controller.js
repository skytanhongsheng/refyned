import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js/auto";

// Connects to data-controller="doughnut-progress-chart"
export default class extends Controller {
  static values = {
    input: Array,
    colors: Array,
  };

  connect() {
    const ctx = this.element;
    console.log(ctx);
    console.log(this);
    new Chart(ctx, {
      type: "doughnut",
      data: {
        datasets: [
          {
            // label: "No. of lessons",
            data: this.inputValue,
            borderWidth: 1,
            backgroundColor: this.colorsValue,
          },
        ],
      },
    });
  }
}
