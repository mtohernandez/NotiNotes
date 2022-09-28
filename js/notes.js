"use strict";

const plus_btn = document.querySelector(".nav__button-plus"),
  note_creator = document.querySelector(".note__creator"),
  note_creator_close = document.querySelector(".note__creator-close"),
  notes_container = document.getElementById("note-container"),
  note_creator_btn = document.querySelector(".note__creator-btn"),
  note_title = document.querySelector(".form_title-input"),
  note_description = document.querySelector(".form_description-input"),
  note_title_check = document.querySelector('.input-check-title'),
  note_description_check = document.querySelector('.input-check-description'),
  note_tag_check = document.querySelector('.input-check-tags');

const colors_note = document.querySelectorAll(".color"),
  tags_empty = document.querySelector(".tags__empty"),
  tag_creator = document.querySelector(".tag__creator");

const form = document.getElementById("note-creator-form"),
  form_title = document.querySelector(".form_title-input"),
  form_description = document.querySelector(".form_description-input");

const masonry = new Masonry(notes_container, {
  itemSelector: ".note",
  gutter: 10,
  horizontalOrder: true,
  trasitionDuration: '0.2s'
});

const months = ["January", "February", "March", "April", "May", "June", "July",
              "August", "September", "October", "November", "December"];

let notes = [];

plus_btn.addEventListener("click", function () {
  form_title.value = "";
  form_description.value = "";
  tag_creator.value = "";
  note_creator.classList.remove("hidden");
  note_title_check.classList.add('hidden');
  note_description_check.classList.add('hidden');
  note_tag_check.classList.add('hidden');
});

note_creator_close.addEventListener("click", function () {
  note_creator.classList.add("hidden");
});

window.addEventListener("load", () => {
  if (document.querySelectorAll(".tag").length === 0) {
    tags_empty.classList.remove("hidden");
  }
});


tag_creator.addEventListener("keydown", function (e) {
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
});

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

note_creator_btn.addEventListener("click", function (e) {

  e.preventDefault(); /* Prevent form */

  const note = document.createElement("div"),
    note_header = document.createElement("div"),
    note_description_div = document.createElement("div"),
    note_footer = document.createElement("div"),
    note_options = document.createElement("div"),
    note_edit = document.createElement("div");

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
  dot_icon.classList.add('note__options-dots')
  dot_icon.src = "../assets/icons/3-dots.svg";
  dot_icon.alt = "3-dots";

  const edit_button = document.createElement("p"),
     delete_button = document.createElement("p");
  
  edit_button.textContent = 'Edit';
  delete_button.textContent = 'Delete';

  note_edit.classList.add('note__edit');
  note_edit.appendChild(edit_button);
  note_edit.appendChild(delete_button);

  dot_icon.addEventListener('click', function(){
    note_edit.classList.remove('hidden');
  })

  note_options.appendChild(dot_icon);
  // note_options.appendChild(note_edit);

  note_header.appendChild(note_title_text);
  note_header.appendChild(note_title_date);
  note_description_div.appendChild(note_description_text);
  note_footer.appendChild(note_tags);
  note_footer.appendChild(note_options);
  

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
});
