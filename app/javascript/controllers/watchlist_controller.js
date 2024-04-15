import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="watchlist"
export default class extends Controller {
  connect() {
  }

  follow() {
    // console.log("click logged!")

    let thisheart = this.element;
    if (thisheart.classList.contains("fa-regular")) {
      thisheart.classList.remove("fa-regular");
      thisheart.classList.add("fa-solid");
      console.log("Now Following!");

    } else {
      thisheart.classList.remove("fa-solid");
      thisheart.classList.add("fa-regular");
      console.log("Unfollowed :(");

    }


  }
}
