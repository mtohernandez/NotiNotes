@extends('layouts.main')

@section('main-container')
    <main id="main">
      <section class="section-form flex">
        <div class="form capitalize">

          <canvas id="gradient-canvas-login"></canvas>

          <h2>NotiNotes</h2>
          <h4 class="js-toggle-text">login</h4>
          <p>No need of this. If you'd like to start instantly just go to notes!</p>

          <!-- Login Form -->
          <form action="#" class="form--login">
            <ul class="form--login__list">
              <li class="form--login__list-item">
                <img src="../assets/icons/cib_mail-ru.svg" alt="mail-icon" />
                <input
                  id="email-in"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">email:</span>
                </label>
              </li>
              <li class="form--login__list-item">
                <img
                  src="../assets/icons/ant-design_lock-outlined.svg"
                  alt="user-icon"
                />
                <input
                  id="password-in"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">password:</span>
                </label>
              </li>
            </ul>
          </form>

          <!-- Register Form -->
          <form action="#" class="form--register hidden" > <!-- ! hidden default -->
            <ul class="form--register__list">
              <li class="form--register__list-item">
                <img
                  src="../assets/icons/ant-design_user-outlined.svg"
                  alt="name-icon"
                />
                <input
                  id="name-up"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">name:</span>
                </label>
              </li>
              <li class="form--register__list-item">
                <img
                  src="../assets/icons/ant-design_user-outlined.svg"
                  alt="surname-icon"
                />
                <input
                  id="surname-up"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">surname:</span>
                </label>
              </li>
              <li class="form--register__list-item">
                <img src="../assets/icons/cib_mail-ru.svg" alt="mail-icon" />
                <input
                  id="email-up"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">email:</span>
                </label>
              </li>
              <li class="form--register__list-item">
                <img
                  src="../assets/icons/ant-design_lock-outlined.svg"
                  alt="lock-icon"
                />
                <input
                  id="password-up"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase">password:</span>
                </label>
              </li>
              <li class="form--register__list-item">
                <img
                  src="../assets/icons/ant-design_lock-outlined.svg"
                  alt="lock-icon"
                />
                <input
                  id="password-confirm-up"
                  type="password"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="password" class="form-label">
                  <span class="content-name uppercase">
                    confirm password:
                  </span>
                </label>
              </li>
              <li class="form--register__list-item">
                <img
                  src="../assets/icons/akar-icons_phone.svg"
                  alt="phone-icon"
                />
                <input
                  id="phone-up"
                  type="text"
                  name="text"
                  autocomplete="off"
                  required
                />
                <label for="text" class="form-label">
                  <span class="content-name uppercase"> phone: </span>
                </label>
              </li>
            </ul>
          </form>

          <!-- Registration/Login toggle -->
          <div class="account-details">
            <p class="js-toggle-label">no account yet?</p>
            <span class="js-toggle-form underline">sign up</span>
          </div>



          <!-- Sign Up Sign In Buttons
            This button will be imported from JS to change dynamically
          -->
          <button class="js-toggle-button form-button-login capitalize" type="submit" form="form--login">
            log in
          </button>
        </div>
      </section>
    </main>


@endsection
