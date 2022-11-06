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

