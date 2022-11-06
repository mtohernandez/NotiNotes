@extends('frontend.layouts.header')
  
@section('main-container')    
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
@endsection