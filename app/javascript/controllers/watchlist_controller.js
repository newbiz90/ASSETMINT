import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="watchlist"
export default class extends Controller {
  static values = {
    userTickerId: String,
    userId: String
  }

  connect() {
    // console.log(this.userTickerIdValue);
  }

  follow() {
    let thisheart = this.element;
    if (thisheart.classList.contains("fa-regular")) {
      thisheart.classList.remove("fa-regular");
      thisheart.classList.add("fa-solid");

      let url = '/subscriptions'
      let userTickerId = this.userTickerIdValue;

      var token = document.querySelector('meta[name="csrf-token"]').content

      fetch(url, {
        method: 'POST',
        body: JSON.stringify({
          "authenticity_token": token,
          "subscription": {
            "subscribable_type": "UserTicker",
            "subscribable_id": userTickerId
          }
        }), // Convert JSON object to string
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json"
        }
      })
      .then(response => {
        if (response.ok) {
          console.log("Now Following")
        } else {
          console.log("Something wrong")
        }
      })
      .catch(error => console.error('Error:', error));

    } else {
      thisheart.classList.remove("fa-solid");
      thisheart.classList.add("fa-regular");

      let url = `/subscriptions/${userid}`
      let userId = this.userIdValue;

      var token = document.querySelector('meta[name="csrf-token"]').content

      fetch(url, {
        method: 'DELETE',
        body: JSON.stringify({
          "authenticity_token": token,
          "subscription": {
            "subscription_type": "UserTicker",
            "subscription_id": userTickerId
          }
        }), // Convert JSON object to string
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json"
        }
      })
      .then(response => {
        if (response.ok) {
          console.log("Now Following")
        } else {
          console.log("Something wrong")
        }
      })
      .catch(error => console.error('Error:', error));
    }


  }
}
