"use strict";

let notes = [];
const months = ["January", "February", "March", "April", "May", "June", "July",
              "August", "September", "October", "November", "December"];

let plus_btn,note_creator ,        
  note_creator_close ,  
  notes_container ,     
  note_creator_btn ,    
  note_title ,          
  note_description ,    
  note_title_check ,    
  note_description_check , note_tag_check;        

let colors_note,
  tags_empty,
  tag_creator;

let form,
  form_title,
  form_description;

let masonry; 

function inicializarNotas(){
  plus_btn =               document.querySelector(".nav__button-plus");          
  note_creator =           document.querySelector(".note__creator");
  note_creator_close =     document.querySelector(".note__creator-close");
  notes_container =        document.getElementById("note-container");
  note_creator_btn =       document.querySelector(".note__creator-btn");
  note_title =             document.querySelector(".form_title-input");
  note_description =       document.querySelector(".form_description-input");
  note_title_check =       document.querySelector('.input-check-title');
  note_description_check = document.querySelector('.input-check-description');
  note_tag_check =         document.querySelector('.input-check-tags'); 
}

function inicializarTags(){
  colors_note = document.querySelectorAll(".color");
  tags_empty = document.querySelector(".tags__empty");
  tag_creator = document.querySelector(".tag__creator");
}

function inicializarFormulario(){
  form = document.getElementById("note-creator-form");
  form_title = document.querySelector(".form_title-input");
  form_description = document.querySelector(".form_description-input");
}

function abrirVentana() {
  form_title.value = "";
  form_description.value = "";
  tag_creator.value = "";
  note_creator.classList.remove("hidden");
  note_title_check.classList.add('hidden');
  note_description_check.classList.add('hidden');
  note_tag_check.classList.add('hidden');
}

function crearEtiqueta(e){

  if (
    e.key === "Enter" &&
    tag_creator.value !== ""
  ) {
    e.preventDefault();
    tags_empty.classList.add("hidden");
    const tags_container = document.querySelector(".tags"),
      tag = document.createElement("div"),
      tag_name = document.createElement("span"),
      tag_close = document.createElement("div"),
      tag_x = document.createElement("img");

    tag_name.classList.add("tag_name");
    tag_name.textContent = tag_creator.value;
    tag_close.classList.add("tag_close");
    tag_x.classList.add("tag_close-item");
    tag_x.src = "../assets/icons/x-lg.svg";
    tag_close.appendChild(tag_x);
    tag.appendChild(tag_name);
    tag.appendChild(tag_close);
    tag.classList.add("tag");

    tags_container.appendChild(tag);
    tag_creator.value = "";

    tag_close.addEventListener("click", function () {
      tags_container.removeChild(tag);

      if (document.querySelectorAll(".tag").length === 0) {
        tags_empty.classList.remove("hidden");
      }
    });
  }
}

function ocultarNota() {
  note_creator.classList.add("hidden");
}

function notasDeColores(){
  for (let i = 0; i < colors_note.length; i++) {
    if (!colors_note[i].classList.contains("color-clicked")) {
      colors_note[i].addEventListener("click", function () {
        colors_note[i].classList.toggle("color-clicked");

        for (let item of colors_note) {
          if (item !== colors_note[i]) {
            item.classList.remove("color-clicked");
          }
        }
      });
    }
  }
}

function crearNota(e) {

  e.preventDefault(); /* Prevent form */

  const note = document.createElement("div"),
    note_header = document.createElement("div"),
    note_description_div = document.createElement("div"),
    note_footer = document.createElement("div"),
    note_options = document.createElement("div");

  const tags = document.querySelectorAll(".tag_name");
  
  if(document.querySelector('.color-clicked')){
    const color_selection = document.querySelector(".color-clicked"),
    color = window.getComputedStyle(color_selection);
    note.style.backgroundColor = color.backgroundColor;

  }else{
    note.style.backgroundColor = '#F5F5F5';
  }

  note.classList.add("note");
  note_header.classList.add("note__header");
  note_description_div.classList.add("note__description");
  note_footer.classList.add("note__footer");
  note_options.classList.add("note__options");

  const note_title_text = document.createElement("p"),
    note_title_date = document.createElement('p');
  note_title_text.textContent = note_title.value;

  let dateObj = new Date(),
  month = months[dateObj.getMonth()],
  day = dateObj.getDate(),
  year = dateObj.getFullYear();

  note_title_date.textContent = `${month} ${day}, ${year}`

  const note_description_text = document.createElement("p");
  note_description_text.textContent = note_description.value;

  const note_tags = document.createElement("div");
  note_tags.classList.add("note__tags");
  for (let i of tags) {
    const text_tag = document.createElement("p");
    text_tag.classList.add("note__tag");
    text_tag.textContent = i.textContent;
    note_tags.appendChild(text_tag);
  }

  const dot_icon = document.createElement("img");
  dot_icon.src = "../assets/icons/3-dots.svg";
  dot_icon.alt = "3-dots";

  note_header.appendChild(note_title_text);
  note_header.appendChild(note_title_date);
  note_description_div.appendChild(note_description_text);
  note_footer.appendChild(note_tags);
  note_footer.appendChild(note_options);
  note_options.appendChild(dot_icon);

  note.appendChild(note_header);
  note.appendChild(note_description_div);
  note.appendChild(note_footer);

  /* Note saving on local storage */

  if (note_title.value && note_description.value && document.querySelectorAll('.tag').length <= 6) {
    notes_container.appendChild(note);
    masonry.appended(note);
    masonry.layout();
    note_title_check.classList.add('hidden');
    note_description_check.classList.add('hidden');

    // let noteInfo = {
    //   title: note_title.value,
    //   description: note_description.value,
    //   date: note_title_date.textContent,
    // }

    // notes.push(noteInfo);
    // localStorage.setItem('note', JSON.stringify(notes))

  }else{
    if(!note_title.value){
      note_title_check.classList.remove('hidden');
    }
    if(!note_description.value){
      note_description_check.classList.remove('hidden');
    }
    if(document.querySelectorAll('.tag').length > 6){
      note_tag_check.classList.remove('hidden');
    }
  }
}

function init(){
  inicializarNotas();
  inicializarTags();
  inicializarFormulario();
  masonry = new Masonry(notes_container, {
    itemSelector: ".note",
    gutter: 10,
    horizontalOrder: true,
    trasitionDuration: '0.2s'
  });
  
  plus_btn.addEventListener("click", abrirVentana);
  note_creator_close.addEventListener("click", ocultarNota);
  tag_creator.addEventListener("keydown", crearEtiqueta);
  note_creator_btn.addEventListener("click", crearNota);

  notasDeColores();
}


window.addEventListener("load", () => {
  if (document.querySelectorAll(".tag").length === 0) {
    tags_empty.classList.remove("hidden");
  }

  init();
});