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
  isFitWidth: true /* Life saver */,
  trasitionDuration: "0.15s",
});

const noteCreator = document.querySelector(".note-creator-container"),
  noteButton = document.querySelector(".note-button"),
  noteOverlay = document.querySelector(".overlay");

noteButton.addEventListener("click", () => {
  noteCreator.classList.remove("hidden");
  noteOverlay.classList.remove("hidden");
});

noteOverlay.addEventListener("click", () => {
  noteCreator.classList.add("hidden");
  noteOverlay.classList.add("hidden");
});
