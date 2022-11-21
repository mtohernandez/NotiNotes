<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="{{url('css/root.css')}}">
  <link rel="stylesheet" href="{{url('css/navBar.css')}}">
  <link rel="stylesheet" href="{{url('css/home.css')}}">
  <link rel="stylesheet" href="{{url('css/notes.css')}}">
  <link rel="stylesheet" href="{{url('css/open.css')}}">
  <link rel="stylesheet" href="{{url('css/wall.css')}}">
  <link rel="stylesheet" href="{{url('css/about.css')}}">
  <link rel="stylesheet" href="{{url('css/login.css')}}">
  <link rel="stylesheet" href="{{url('css/footer.css')}}">
  <!-- Start firebase for the whole project -->
  <title>Home</title>
</head>

<body>

  <header class="header" id="header">
    <nav class="nav">
      <a href={{url('/')}} class="nav__logo">NN</a>

      <div class="nav__menu" id="nav-menu">
        <ul class="nav__list">
          <li class="nav__item">
            <a href={{url('/Notes')}} class="nav__link"> notes </a>
          </li>
          <li class="nav__item">
            <a href={{url('/Wall')}} class="nav__link"> the wall </a>
          </li>
          <li class="nav__item">
            <a href={{url('/Open')}} class="nav__link"> open-source </a>
          </li>
          <li class="nav__item">
            <a href={{url('/Donations')}} class="nav__link"> support </a>
          </li>
          <li class="nav__item">
            <a href={{url('/About')}} class="nav__link"> about </a>
          </li>

          <div class="nav__link">
            <a href={{url('/Login')}} class="button nav__button"> login </a>
          </div>
        </ul>

        <div class="nav__close" id="nav__close">x</div>
      </div>

      <div class="nav__toggle" id="nav__toggle">
        <img src={{url("assets/icons/menu.svg")}} alt="menu-logo" />
      </div>

      <div class="overlay hidden"></div>
    </nav>
  </header>

