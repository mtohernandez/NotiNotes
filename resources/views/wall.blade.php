@extends('layouts.main')

@section('main-container')
  <main id="main">
    <section class="wall-section">
      <div class="items-bar flex">
        <ul class="items-bar__list flex">
          <li class="items-item">
            Heading 1
          </li>
          <li class="items-item">
            Heading 2
          </li>
          <li class="items-item">
            Heading 3
          </li>
          <li class="items-item">
            Heading 4
          </li>
          <li class="items-item">
            Heading 5
          </li>
          <li class="items-item">
            Heading 6
          </li>
          <li class="items-item">
            Paragraph
          </li>
          <li class="items-item">
            <input type="file"  accept="image/*" name="image" id="file"  onchange="loadFile(event)" style="display: none;">
            <label for="file">Image</label>
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
  <script src="{{url('js/wall.js')}}"></script>
@endsection
