// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

window.paintIt = function(event, backgroundColor, textColor) {
  event.preventDefault();
  event.target.style.backgroundColor = backgroundColor;
  if (textColor) {
    event.target.style.color = textColor;
  }
}

window.addEventListener("load", () => {
  const element = document.querySelector("#order_paint_id");
  element.addEventListener("ajax:success", (event) => {

    console.log("a");
  });
  element.addEventListener("ajax:error", () => {

    console.log("detail");
  });
  
});


document.addEventListener('DOMContentLoaded', function(){
	var elem = document.getElementById('order_paint_id');
	elem.addEventListener('change', function(){
		var paint_id = elem.value;
		console.log(paint_id);
	}, false);
}, false);