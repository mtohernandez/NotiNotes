"use strict";

window.onload = () => {
  const white = "#fff";
  const nav = document.querySelector(".nav");
  nav.style.backgroundColor = white;
};

const elem = document.querySelector(".notes-section__container");

const masonry = new Masonry(elem, {
  itemSelector: ".note",
  gutter: 15,
  percentPosition: true,
  trasitionDuration: "0.15s",
});

