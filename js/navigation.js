const openNav = document.getElementById("nav__toggle"),
closeNav = document.getElementById("nav__close"),
navBar = document.getElementById("nav-menu"),
overlay = document.querySelector(".overlay");

if (openNav) {
openNav.addEventListener("click", function () {
  navBar.classList.add("show-menu");
  overlay.classList.remove('hidden');
});
}

if (closeNav) {
closeNav.addEventListener("click", function () {
  navBar.classList.remove("show-menu");
  overlay.classList.add('hidden');
});
}