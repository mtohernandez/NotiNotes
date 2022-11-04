<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/root.css">
  <link rel="stylesheet" href="../css/navBar.css">
  <link rel="stylesheet" href="../css/open.css">
  <title>Open Source</title>
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
    <section class="open-section flex">
      <img src="../assets/img/open-source.png" alt="open-image">
    </section>
  </main>

  <script src="../js/navigation.js"></script>
</body>
</html>