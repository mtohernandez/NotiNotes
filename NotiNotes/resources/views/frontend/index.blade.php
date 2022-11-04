<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./css/footer.css">
  <link rel="stylesheet" href="./css/home.css">
  <link rel="stylesheet" href="./css/navBar.css">
  <link rel="stylesheet" href="./css/root.css">
  <title>Home</title>
</head>

<body>

  <!-- Diagonal purple -->
  <div class="diagonal-box"></div>

  <header class="header" id="header">
    <nav class="nav">
      <a class="nav__logo">NN</a>

      <div class="nav__menu" id="nav-menu">
        <ul class="nav__list">
          <li class="nav__item">
            <a href="./pages/notes.html" class="nav__link"> notes </a>
          </li>
          <li class="nav__item">
            <a href="./pages/wall.html" class="nav__link"> the wall </a>
          </li>
          <li class="nav__item">
            <a href="./pages/open.html" class="nav__link"> open-source </a>
          </li>
          <li class="nav__item">
            <a href="./pages/donations.html" class="nav__link"> support </a>
          </li>
          <li class="nav__item">
            <a href="./pages/about.html" class="nav__link"> about </a>
          </li>

          <div class="nav__link">
            <a href="./pages/login.html" class="button nav__button"> login </a>
          </div>
        </ul>

        <div class="nav__close" id="nav__close">x</div>
      </div>

      <div class="nav__toggle" id="nav__toggle">
        <img src="./assets/icons/menu.svg" alt="menu-logo" />
      </div>

      <div class="overlay hidden"></div>
    </nav>
  </header>


  <!-- Refactor -->

  <main id="main">
    <section class="section-grid grid">

      <!-- Title -->
      <div class="card--title">
        <h1>NotiNotes</h1>
        <h1>NotiNotes</h1>
        <p>create notes fast. like now. really.</p>
        <p>create notes fast. like now. really.</p>
      </div>

      <!-- Resizable cards card -->
      <div class="card card--resize flex">
        <img src="./assets/img/card-resize-cards.png" alt="resizable-cards-image">
        <div class="card--resize__content flex">
          <p>watch trailer.</p>
          <p>more info.</p>
        </div>
      </div>

      <!-- Start now card -->
      <div class="card card--start flex">
        <p>ready to start?</p>
        <h3>everything will be set in seconds.</h3>
        <button class="capitalize" onclick="window.location.href='./pages/notes.html'" class="downwards__leftside-upper__leftside-card-item__button">start<img src="./assets/icons/play.svg" alt="start-icon"></button>
      </div>

      <!-- Mobile version card -->
      <div class="card card--mobile flex">
        <img src="./assets/img/card-mobile-version.png" alt="mobile-version-image">
        <img src="./assets/img/phone.png" alt="phone-image">
      </div>

      <!-- Collapse for fun card -->
      <div class="card card--collapse flex">
        <canvas id="gradient-canvas"></canvas>
        <img src="./assets/img/card-collapse-fun.png" alt="collapse-forfun-image">
      </div>

      <!-- Change colors for fun card -->
      <div class="card card--colors flex">
        <img src="./assets/img/card-change-theme.png" alt="change-colors-image">
        <div class="card--colors__circle">
          <span class="circle"></span>
          <span class="circle"></span>
          <span class="circle"></span>
        </div>
      </div>

      <!-- Custom layout card -->
      <div class="card card--layout flex">
        <img src="./assets/img/card-custom-layout.png" alt="card-layout">
      </div>

    </section>
  </main>


  <!-- The footer needs to be redesigned -->
  <footer id="footer" class="footer">
      <p>@ All rights reserved NotiNotes App</p>
      <p>Mateo Hernandez</p>
      <p>Aura Marcela</p>
  </footer>


  <script src="./js/navigation.js"></script>
  <script type="module" src="./js/gradientIm.js"></script>
</body>
</html>