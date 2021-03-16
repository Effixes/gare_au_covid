import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
  }

  viewCard() {
    console.log("card view")

    let cardViewer = document.getElementById("card-viewer");
    let drawCard   = document.getElementById('draw-card');

    let currentImage = this.element.getElementsByTagName('img')[0].currentSrc;

    cardViewer.src = currentImage;
    cardViewer.style.opacity = 1;

    if (drawCard) {
      drawCard.style.display = "none";
    }
  }

  hideCard() {
    console.log("card hidden")

    let cardViewer = document.getElementById("card-viewer");

    cardViewer.style.opacity = 0;
  }
}
