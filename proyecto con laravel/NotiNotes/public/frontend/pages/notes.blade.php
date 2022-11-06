<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/notes.css" />
    <link rel="stylesheet" href="../css/navBar.css" />
    <link rel="stylesheet" href="../css/root.css" />
    <title>Note App</title>
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

    <div class="note-creator">
      <img src="../assets/icons/plus-circle.svg" alt="plus-icon"/>
    </div>

    <main id="main">
      <section class="notes-section flex">
        <div class="search-bar flex">
          <input type="text" placeholder="search">
          <div class="search-bar__icon"> <!-- For background rounded -->
            <img src="../assets/icons/search.svg" alt="search-icon">
          </div>
        </div>

        
        <div class="notes-section__container">

          <!-- Note Template -->
          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!this is the content of a note, hi! I'm the first note ever created inside NotiNotesthis is the content of a note, hi! I'm the first note ever created inside NotiNotes</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!this is the content of a note, hi! I'm the first note ever created inside NotiNotesthis is the content of a note, hi! I'm the first note ever created inside NotiNotes</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

          <div class="note">
            <div class="note__upper flex">
              <h2>Title</h2>
              <span>Date Created</span>
            </div>
            <p>this is the content of a note, hi! I'm the first note ever created inside NotiNotes!</p>
            <div class="note__bottom flex">
              <ul class="note-tags flex">
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
                <li class="note-tag">
                  <span>tag</span>
                </li>
              </ul>
              <img src="../assets/icons/3-dots.svg" alt="3-dots" />
            </div>
          </div>

        </div>
      </section>
    </main>

    <footer id="footer" class="footer">
      <p>@ All rights reserved NotiNotes App</p>
      <p>Mateo Hernandez</p>
      <p>Aura Marcela</p>
    </footer>

    <script src="../js/navigation.js"></script>
    <script src="../js/masonry.pkgd.min.js"></script>
    <script src="../js/notes.js"></script>
  </body>
</html>
