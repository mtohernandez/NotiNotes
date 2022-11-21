'use strict';

window.onload = () => {
  const white = "#fff";
  const nav = document.querySelector(".nav");
  nav.style.backgroundColor = white;
};

const items = document.querySelectorAll(".items-item"),
  wall = document.querySelector(".wall-container");

let wallElements = document.querySelectorAll(".wall-element");

let max = 1000, min = 1;
const randomImg = 'IMG' + Math.trunc(Math.random() * (max - min) + min);

function loadFile(event) {
  const html = `<div class="wall-element" style='display: inline-block'>
                <img src='${URL.createObjectURL(event.target.files[0])}'
                style="width: 300px; height: 300px; object-fit: cover;"/>
                <div contenteditable="false" class="tooltip">-</div>
                </div>`;
  wall.insertAdjacentHTML("beforeend", html)
}



items.forEach((item) => {
  item.addEventListener("click", () => {
    const array = item.textContent.toString().trim().split(' ');
    const type =  array[0][0].toLowerCase() + array[1]
    console.log(type);
    const html = `<div class="wall-element">
                    <${type} style="max-width: 100vw;">
                      <span class="textarea" role="textbox" contenteditable></span>
                      <div contenteditable="false" class="tooltip">-</div>
                    </${type}>
                  </div>`;

    item.textContent.trim() !== 'img' ? wall.insertAdjacentHTML("beforeend", html) : "";
    wallElements = document.querySelectorAll(".wall-element");
    wallElements.forEach((elem) => {
      elem.querySelector(".tooltip").addEventListener("click", () => {
        elem.remove();
      });
    });
  });
});

