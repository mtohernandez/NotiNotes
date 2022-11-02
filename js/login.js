'use strict';

const toggleForm = document.querySelector('.js-toggle-form'),
      toggleLabel = document.querySelector('.js-toggle-label'),
      toggleButton = document.querySelector('.js-toggle-button'),
      toggleText = document.querySelector('.js-toggle-text'),
      formLogin = document.querySelector('.form--login'),
      formRegister = document.querySelector('.form--register');

toggleForm.addEventListener('click', () => {
  toggleText.textContent = toggleText.textContent === 'login' ? 'register' : 'login';
  formLogin.classList.toggle('hidden');
  formRegister.classList.toggle('hidden');
  toggleLabel.textContent = toggleLabel.textContent !== 'already have an account?' ? 'already have an account?' : 'no account yet?';
  toggleForm.innerHTML = toggleForm.innerHTML === 'sign up' ? 'sign in' : 'sign up';
  toggleButton.classList.toggle('form-button-login');
  toggleButton.classList.toggle('form-button-register');
  toggleButton.textContent = toggleButton.textContent !== 'sign up' ? 'sign up'  : 'log in';
})
