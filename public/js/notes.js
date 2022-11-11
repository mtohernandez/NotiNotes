"use strict";

import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";


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

const firebaseConfig = {
    apiKey: "{{config('services.firebase.apiKey')}}",
    authDomain: "{{config('services.firebase.authDomain')}}",
    projectId: "{{config('services.firebase.projectId')}}",
    storageBucket: "{{config('services.firebase.storageBucket')}}",
    messagingSenderId: "{{config('services.firebase.messagingSenderId')}}",
    appId: "{{config('services.firebase.appId')}}",
    measurementId: "{{config('services.firebase.measurementId')}}"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);


// Firebase Credentials

// Create Note

// Edit Note

// Update Note

// Delete Note
