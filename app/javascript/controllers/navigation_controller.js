import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let navbar = document.querySelector("#zh_nav")

    navbar.addEventListener("mouseover", this.overHandler)
    navbar.addEventListener("mouseleave", this.awayHandler)
    navbar.addEventListener("click", this.clickHandler)
  }

  clickHandler = (event) => {
    let navbarLinks = document.querySelectorAll("#zh_nav a")
    navbarLinks.forEach((link) => {
      link.style.color = "#b3b3b3";
    });
    event.target.style.color = "black";
  }

  awayHandler = (event) => {
    this.hoveringElement = false;
    let animationPill = document.querySelector("#hover_pill")
    animationPill.style.transitionDuration = "0ms";
    animationPill.style.opacity = `0`;
  }

  overHandler = (event) => {
    let animationPill = document.querySelector("#hover_pill")
    let navbarLinks = document.querySelectorAll("#zh_nav a")

    animationPill.style.opacity = `1`;
    let count = Array.from(navbarLinks).indexOf(event.target);

    if (count < 0) return;

    if (this.hoveringElement || this.hoveringElement === undefined) {
      animationPill.style.transitionDuration = "160ms";
    } else {
      this.hoveringElement = true;
      animationPill.style.transitionDuration = "0ms";
    }
    let width = 0;
    for (let i = 0; i < count; i++) {
      width += navbarLinks[i].offsetWidth;
    }
    animationPill.style.width = `${event.target.offsetWidth}px`;
    animationPill.style.height = `${event.target.offsetHeight}px`;
    animationPill.style.transform = `translate(${width}px)`;
  }
}
