import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["joinButton", "leaveButton"];

  connect() {
    console.log("dashboard controller connected");
  }

  joinEvent(event) {
    // var url = $(event.target).parent("form").attr("action");
    // this.fetchAndUpdate(url, "POST");
  }

  leaveEvent() {}

  fetchAndUpdate(url, method) {
    fetch(url, {
      method: method,
      headers: {
        Accept: "text/vnd.turbo-stream.html, text/html, application/xhtml+xml",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": this.getMetaContent("csrf-token"),
        "Cache-Control": "no-cache",
      },
    })
      .then((response) =>
        response.ok ? response.text() : Promise.reject("Response not OK")
      )
      .then((html) => Turbo.renderStreamMessage(html))
      .catch((error) => console.error("Error:", error));
  }

  getMetaContent(name) {
    return document
      .querySelector(`meta[name="${name}"]`)
      .getAttribute("content");
  }
}
