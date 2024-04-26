import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("DOMContentLoaded", function() {
  const searchInput = document.getElementById('search_email');
  const searchResults = document.querySelector('.search-results');

  // Update placeholder if no users are found
  if (searchResults && searchResults.innerText.trim() === "No user found.") {
    searchInput.placeholder = "No user found";
  }
});
