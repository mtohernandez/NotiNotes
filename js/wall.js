window.onload = () => {
  const white = "#fff";
  const nav = document.querySelector(".nav");
  nav.style.backgroundColor = white;
};


const items = document.querySelectorAll('.items-item'),
wall = document.querySelector('.wall-container');

let wallElements = document.querySelectorAll('.wall-element');

items.forEach(item => {
  item.addEventListener('click', () => {
    const html = `<div class="wall-element"> 
                  <${item.textContent.trim()} contenteditable="true">Add Content Here...
                  <div contenteditable="false" class="tooltip">-</div></${item.textContent.trim()}>
                  </div>`;
    
    wall.insertAdjacentHTML('beforeend', html);
    wallElements = document.querySelectorAll('.wall-element')
    wallElements.forEach(elem => {
      
      elem.querySelector('.tooltip').addEventListener('click', () => {
        elem.remove();
      })
    })
  })
})

