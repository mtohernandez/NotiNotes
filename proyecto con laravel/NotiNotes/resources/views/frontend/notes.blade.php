@extends('frontend.layouts.header')
  
@section('main-container')
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
@endsection