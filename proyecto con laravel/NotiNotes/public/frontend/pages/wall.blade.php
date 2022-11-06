<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/root.css">
  <link rel="stylesheet" href="../css/navBar.css">
  <link rel="stylesheet" href="../css/wall.css">
  <title>The wall</title>
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
    <section class="wall-section">
      <div class="items-bar flex">
        <ul class="items-bar__list flex">
          <li class="items-item">
            h1
          </li>
          <li class="items-item">
            h2
          </li>
          <li class="items-item">
            h3
          </li>
          <li class="items-item">
            h4
          </li>
          <li class="items-item">
            h5
          </li>
          <li class="items-item">
            h6
          </li>
          <li class="items-item">
            p
          </li>
          <li class="items-item">
            <input type="file"  accept="image/*" name="image" id="file"  onchange="loadFile(event)" style="display: none;">
            <label for="file">img</label> 
          </li>
        </ul>
      </div>

      <!-- Wall Section -->
      <div class="wall-container">

        <div class="wall-element"> 
          <h1>
            <span class="textarea" role="textbox" contenteditable></span>
            <div contenteditable="false" class="tooltip">-</div>
          </h1>
        </div>
        
      </div>
    </section>
  </main>

  <script src="../js/navigation.js"></script>
  <script src="../js/wall.js"></script>
</body>
</html>