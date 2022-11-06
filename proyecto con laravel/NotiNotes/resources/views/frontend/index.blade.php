@extends('frontend.layouts.header')
  
@section('main-container')
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
@endsection

