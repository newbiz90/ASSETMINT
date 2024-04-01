import { Controller } from "stimulus";

export default class extends Controller {
  follow(event) {
    event.preventDefault();
    let userId = this.element.dataset.userId;

    // Make an AJAX request to follow the user
    fetch(`/users/${userId}/follow`, { method: "POST", credentials: "same-origin" })
      .then(response => response.json())
      .then(data => {
        // Update the DOM
        if (data.success) {
          this.element.innerHTML = data.buttonHtml;
        }
      });
  }
}
