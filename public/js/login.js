"use strict";

import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";
const activePage = window.location;
/* This will allow to change colors on load */
console.log(
    activePage.toString().slice([activePage.toString().lastIndexOf("/") + 1])
);
if (
    activePage
        .toString()
        .slice([activePage.toString().lastIndexOf("/") + 1]) !== "Login"
) {
} else {
    window.onload = () => {
        const white = "#fff";
        const nav = document.querySelector(".nav__logo");
        const navToggle = document.querySelector(".nav__toggle");
        const navLinks = document
            .querySelectorAll(".nav__item .nav__link")
            .forEach((link) => {
                link.style.color = white;
            });
        navToggle.style.filter =
            "invert(100%) sepia(100%) saturate(0%) hue-rotate(281deg) brightness(106%) contrast(106%)";
        nav.style.color = white;
    };
}

const toggleForm = document.querySelector(".js-toggle-form"),
    toggleLabel = document.querySelector(".js-toggle-label"),
    toggleButton = document.querySelector(".js-toggle-button"),
    toggleText = document.querySelector(".js-toggle-text"),
    formLogin = document.querySelector(".form--login"),
    formRegister = document.querySelector(".form--register");

toggleForm.addEventListener("click", () => {
    toggleText.textContent =
        toggleText.textContent === "login" ? "register" : "login";
    formLogin.classList.toggle("hidden");
    formRegister.classList.toggle("hidden");
    toggleLabel.textContent =
        toggleLabel.textContent !== "already have an account?"
            ? "already have an account?"
            : "no account yet?";
    toggleForm.innerHTML =
        toggleForm.innerHTML === "sign up" ? "sign in" : "sign up";
    toggleButton.classList.toggle("form-button-login");
    toggleButton.classList.toggle("form-button-register");
    toggleButton.textContent =
        toggleButton.textContent !== "sign up" ? "sign up" : "log in";
});

const firebaseConfig = {
    apiKey: "{{config('services.firebase.apiKey')}}",
    authDomain: "{{config('services.firebase.authDomain')}}",
    projectId: "{{config('services.firebase.projectId')}}",
    storageBucket: "{{config('services.firebase.storageBucket')}}",
    messagingSenderId: "{{config('services.firebase.messagingSenderId')}}",
    appId: "{{config('services.firebase.appId')}}",
    measurementId: "{{config('services.firebase.measurementId')}}",
};

console.log(firebaseConfig.apiKey);

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const auth = app.auth();
const database = app.database();
