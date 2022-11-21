"use strict";

import notesApi from './notesApi.js';


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

const notes = document.querySelectorAll(".note"),
    noteCreator = document.querySelector(".note-creator-container"),
    noteButton = document.querySelector(".note-button"),
    noteOverlay = document.querySelector(".overlay-form"),
    noteOptions = document.querySelector(".note__bottom img"),
    noteCrud = document.querySelector(".note-options");

noteButton.addEventListener("click", () => {
    noteCreator.classList.remove("hidden");
    noteOverlay.classList.remove("hidden");
});

noteOverlay.addEventListener("click", () => {
    noteCreator.classList.add("hidden");
    noteOverlay.classList.add("hidden");
});

noteOptions.addEventListener("click", () => {
    noteCrud.classList.toggle("hidden");
});

notes.forEach(note => {
    note.addEventListener('mouseleave', () => {
        note.querySelector('.note-options').classList.add('hidden');
    })


    note.querySelector('.note__upper').addEventListener('click', () => {
        note.querySelector('.note-tags').classList.toggle('visibility');
        note.querySelector('img').classList.toggle('hidden');
        note.querySelector('p').classList.toggle('hidden');
        masonry.layout();
    });
})

// Create Note
notesApi.saveNote({
    id: 1122,
    title: 'title note',
    body: 'This is the content',
    tags: ['tag1', 'tag2', 'tag3'],
    saved: '2022:12:23',
    
})

console.log(notesApi.getAllNotes());

// Edit Note

// Update Note

// Delete Note
