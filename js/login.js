'use strict';

const register = document.querySelector('.register_section'),
  login = document.querySelector('.login_section'),
  signin_toggle = document.querySelector('.signin_toggle'),
  signup_toggle = document.querySelector('.signup_toggle'),
  signup_button = document.querySelector('.signup'),
  signin_button = document.querySelector('.signin'),
  text_option = document.querySelector('.signin_option'),
  form_login = document.getElementById('form-login'),
  email_in = document.getElementById('email-in');


signin_toggle.addEventListener('click', function(){
  register.classList.add('hidden');
  login.classList.remove('hidden');
  text_option.textContent = 'sign in';
  signin_button.classList.remove('hidden');
  signup_button.classList.add('hidden');
})

signup_toggle.addEventListener('click', function(){
  register.classList.remove('hidden');
  login.classList.add('hidden');
  text_option.textContent = 'sign up';
  signin_button.classList.add('hidden');
  signup_button.classList.remove('hidden');
})
