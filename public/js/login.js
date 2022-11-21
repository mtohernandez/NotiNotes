"use strict";

import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";
import { getAuth, createUserWithEmailAndPassword } from "firebase/auth";
import { getAuth } from "firebase/auth";
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import { getAuth, onAuthStateChanged } from "firebase/auth";
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

toggleForm?.addEventListener("click", () => {
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

email= document.getElementById('email-up')
password= document.getElementById('password-up')

const firebaseConfig = {
    apiKey: "AIzaSyBw7Ih0SBN0ib8fIwF_zqWDRY8w3hxeMYo",
    authDomain: "notinotes-c37aa.firebaseapp.com",
    databaseURL: "https://notinotes-c37aa-default-rtdb.firebaseio.com",
    projectId: "notinotes-c37aa",
    storageBucket: "notinotes-c37aa.appspot.com",
    messagingSenderId: "27454562419",
    appId: "1:27454562419:web:90dab40eb631e02d358a06",
    measurementId: "G-3W32VKLK1B"
};

console.log(firebaseConfig.apiKey);

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const auth = app.auth();
const database = app.database();
//registro

createUserWithEmailAndPassword(auth, email, password)
  .then((userCredential) => {
    // Signed in
    const user = userCredential.user;
    // ...
  })
  .catch((error) => {
    const errorCode = error.code;
    const errorMessage = error.message;
    // ..
  });


//inicio de sesion

signInWithEmailAndPassword(auth, email, password)
  .then((userCredential) => {
    // Signed in
    const user = userCredential.user;
    // ...
  })
  .catch((error) => {
    const errorCode = error.code;
    const errorMessage = error.message;
  });

  //observador
onAuthStateChanged(auth, (user) => {
  if (user) {
    // User is signed in, see docs for a list of available properties
    // https://firebase.google.com/docs/reference/js/firebase.User
    const uid = user.uid;
    // ...
  } else {
    // User is signed out
    // ...
  }
});
