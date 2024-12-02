import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="vertical-tabs"
export default class extends Controller {
  static targets = ["tab", "tabContent"];
  connect() {
    console.log("connected to vertical tabs");
    console.log(this.tabTargets);
    console.log(this.tabContentTargets);
  }

  /**
   * Executes when a tab is selected, to hide and show tab content accordingly
   * @param {Event} event
   */
  selectTab(event) {
    const tab = event.target;
    if (!tab.matches('input[type="radio"]')) return;
    this.tabContentTargets.forEach((tabContent) => {
      const { tabId } = tabContent.dataset;
      tabContent.classList[tabId === tab.id ? "remove" : "add"]("d-none");
    });
  }
}
