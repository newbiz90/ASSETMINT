const allHearts = document.querySelectorAll(".fa-regular");
console.log(allHearts);

allHearts.forEach( heart => {
  heart.addEventListener("click", follow => {
    // console.log(follow.target.classList);
    follow.target.classList.toggle("fa-regular");
    follow.target.classList.toggle("fa-solid");
  });
});
