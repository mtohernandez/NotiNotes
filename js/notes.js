"use strict";

window.onload = () => {
  const elem = document.querySelector('.notes-section__container');

  const masonry = new Masonry(elem, {
    itemSelector: ".note",
    gutter: 15,
    percentPosition: true,
    trasitionDuration: '0.15s'
  });
}
