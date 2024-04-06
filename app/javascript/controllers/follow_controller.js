import { Controller } from "stimulus";

export default class extends Controller {
  follow(event) {
    event.preventDefault();
    let userId = this.element.dataset.userId;

    // Make an AJAX request to follow the user
    fetch(`/users/${userId}/follow`, { method: "POST", credentials: "same-origin" })
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to follow the user.');
        }
        return response.json();
      })
      .then(data => {
        // Update the DOM
        if (data.success) {
          // Display the message
          alert("You are now following this user.");

          // Update the followed user count
          let followedUserCountElement = document.getElementById('followed-user-count');
          if (followedUserCountElement) {
            followedUserCountElement.innerText = parseInt(followedUserCountElement.innerText) + 1;
          }
        } else {
          alert("Failed to follow the user.");
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert("Failed to follow the user.");
      });
  }
}
