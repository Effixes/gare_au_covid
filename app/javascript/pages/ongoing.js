const hoverCards = () => {
    let cards = document.querySelectorAll('.card-hover-zoom');
    let cardViewer = document.getElementById("card-viewer");
    let drawCard = document.getElementById('draw-card');

    cards.forEach(function(card) {
        card.addEventListener('mouseover', function hover() {

            let currentImage = card.getElementsByTagName('img')[0].currentSrc;
            cardViewer.src = currentImage;
            cardViewer.style.opacity = "1";

            if (drawCard) {
              drawCard.style.display="none";
            }
        });

        card.addEventListener('mouseleave', function hover() {
            cardViewer.style.opacity = "0";
        });
    });
}
export { hoverCards };
