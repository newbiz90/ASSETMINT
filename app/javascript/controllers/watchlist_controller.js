import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="watchlist"
export default class extends Controller {
  connect() {
  }

  follow() {
    let thisheart = this.element;
    if (thisheart.classList.contains("fa-regular")) {
      thisheart.classList.remove("fa-regular");
      thisheart.classList.add("fa-solid");

      let url = '/subscribeticker'
      let userTickerId = thisheart.id;

      fetch(url, {
        method: 'POST',
        body: JSON.stringify(userTickerId), // Convert JSON object to string
        headers: {
          'Content-Type': 'application/json'
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
      // console.log("Now Following!:)");



    } else {
      thisheart.classList.remove("fa-solid");
      thisheart.classList.add("fa-regular");
      console.log("Unfollowed :(");

    }


  }
}
