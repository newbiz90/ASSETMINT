import { Controller } from "stimulus";

export default class extends Controller {
  unfollow(event) {
    event.preventDefault();
    let userId = this.element.dataset.userId;

    // Make an AJAX request to unfollow the user
    fetch(`/users/${userId}/unfollow`, { method: "DELETE", credentials: "same-origin" })
      .then(response => response.json())
      .then(data => {
        // Update the DOM
        if (data.success) {
          this.element.innerHTML = data.buttonHtml;
        }
      });
  }
}
