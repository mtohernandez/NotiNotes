<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/root.css" />
    <link rel="stylesheet" href="../css/login.css" />
    <link rel="stylesheet" href="../css/navBar.css" />
    <title>Login</title>
  </head>
  <body>
    <header class="header" id="header">
      <nav class="nav">
        <a href="../index.html" class="nav__logo">NN</a>

        <div class="nav__menu" id="nav-menu">
          <ul class="nav__list">
            <li class="nav__item">
              <a href="./notes.html" class="nav__link"> notes </a>
            </li>
            <li class="nav__item">
              <a href="./wall.html" class="nav__link"> the wall </a>
            </li>
            <li class="nav__item">
              <a href="./open.html" class="nav__link"> open-source </a>
            </li>
            <li class="nav__item">
              <a href="./donations.html" class="nav__link"> support </a>
            </li>
            <li class="nav__item">
              <a href="./about.html" class="nav__link"> about </a>
            </li>

            <div class="nav__link">
              <a href="./login.html" class="button nav__button hidden"> login </a>
            </div>
          </ul>

          <div class="nav__close" id="nav__close">x</div>
        </div>

        <div class="nav__toggle" id="nav__toggle">
          <img src="../assets/icons/menu.svg" alt="menu-logo" />
        </div>

        <div class="overlay hidden"></div>
      </nav>
    </header>

    <main id="main">
      <section class="section-form flex">
        <div class="form capitalize">

          <canvas id="gradient-canvas"></canvas>

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

    <footer id="footer" class="footer">
      <p>@ All rights reserved NotiNotes App</p>
      <p>Mateo Hernandez</p>
      <p>Aura Marcela</p>
    </footer>

    <script src="../js/navigation.js"></script>
    <script src="../js/login.js"></script>
    <script type="module" src="../js/gradientIm.js"></script>
  </body>
</html>
