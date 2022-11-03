const activePage = window.location;
const navLinks = document.querySelectorAll(".nav__item .nav__link").forEach((link) => {
  if (link.href.includes(`${activePage}`)) {
    link.classList.add("active");
  }else{
    link.classList.remove("active");
  }
});

const openNav = document.getElementById("nav__toggle"),
  closeNav = document.getElementById("nav__close"),
  navBar = document.getElementById("nav-menu"),
  overlay = document.querySelector(".overlay");

if (openNav) {
  openNav.addEventListener("click", function () {
    navBar.classList.add("show-menu");
    overlay.classList.remove("hidden");
  });
}

if (closeNav) {
  closeNav.addEventListener("click", function () {
    navBar.classList.remove("show-menu");
    overlay.classList.add("hidden");
  });
}
