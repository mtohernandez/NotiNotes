@extends('frontend.layouts.header')
  
@section('main-container')
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
@endsection