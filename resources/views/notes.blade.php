@extends('layouts.main')

@section('main-container')
    <div class="note-button">
        <img src="../assets/icons/plus-circle.svg" alt="plus-icon" />
    </div>

    <div class="note-creator-container flex hidden">
        <div class="note-creator capitalize flex">
            <h4>NotiCreator</h4>
            <div class="note-creator__content">
                <input placeholder="title">
                <input placeholder="description">
            </div>
            <p>separate your tags with spaces: tag1 tag2</p>
            <input placeholder="tags">
            <p>pick a color for your note:</p>
            <div class="note-creator__colors flex">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
            <p>click outside to close.</p>
        </div>
    </div>

    <div class="overlay-form hidden"></div>

    <main id="main">
        <section class="notes-section flex">
            <div class="search-bar flex">
                <input type="text" placeholder="search">
                <div class="search-bar__icon">
                    <!-- For background rounded -->
                    <img src="../assets/icons/search.svg" alt="search-icon">
                </div>
            </div>


            <div class="notes-section__container">

                <!-- Note Template -->
                <div class="note">
                    <div class="note__upper flex">
                        <h2>Title</h2>
                        <span>Date Created</span>
                        <img class="hidden" src="../assets/icons/tagsCube.svg" alt="tags-cube">
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
                        <div class="note-options hidden capitalize">
                            <p>delete</p>
                            <p>edit</p>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </main>
    <script src="{{ url('js/masonry.pkgd.min.js') }}"></script>
    <script src="{{ url('js/notes.js') }}"></script>
@endsection
