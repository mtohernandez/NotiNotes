<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../css/about.css">
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/root.css" />
    <link rel="stylesheet" href="../css/navBar.css" />
    <title>About</title>
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
              <a href="./login.html" class="button nav__button"> login </a>
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
      <section class="about-section">
        <div class="about-section__cards">
          <h1>NotiNotes</h1>
          <img src="../assets/img/banner.jpg" alt="banner-image">
        </div>
        <p>Notinotes is the simplest free aesthetically pleasant open source notes app. It started as a practice for javascript in the year 2022 but it slowly became a real project because of all the additional functionalities it could have.</p>
        <p><b>Original founder:</b> Mateo Hernandez</p>
        <p><b>Backend Developer:</b> Aura Marcela</p>
        <p>The main idea was to create a notes app for fast access and no need for login, and of course, free, all notes are mainly saved in your local storage.</p>
        <p>This project does not look for funding but in case you would like to help, we highly appreciate your support!</p>
        <div class="about-section__link">
          <a href="./donations.html">Buy us some bread!</a>
        </div>
      </section>
    </main>

    <footer id="footer" class="footer">
      <p>@ All rights reserved NotiNotes App</p>
      <p>Mateo Hernandez</p>
      <p>Aura Marcela</p>
    </footer>

    <script src="../js/navigation.js"></script>
  </body>
</html>
