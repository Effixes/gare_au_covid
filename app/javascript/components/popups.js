const Swal = require('sweetalert2')

const popups = () => {

  let myTurn = document.getElementById('myturn');

  if (myTurn) {
    const image    = myturn.dataset.image;

    const alive    = myTurn.dataset.alive;
    const winner   = myTurn.dataset.winner;
    const gameOver = myturn.dataset.gameOver;

    // j'ai gagne la partie
    if (winner == 'true') {
      Swal.fire({
        title: 'WINNER!',
        background: '#000000',
        imageUrl: image,
        text: 'Yeahhh, malgré quelques écarts, tu as réussi à éviter la COVID...',
        // icon: 'error',
        // confirmButton:
        confirmButtonText: 'Nouvelle partie ?',
      })
    }
    // partie terminee, j'ai perdu
    else if (gameOver == 'true') {
      Swal.fire({
        title: 'PERDU !!!!',
        background: '#000000',
        imageUrl: image,
        text: 'Partie terminee',
        confirmButtonText: 'BeuuuBye !',
      })
    }
    // J'ai perdu (COVID), le jeu est en cours
    else if (alive == 'false') {
      Swal.fire({
        title: 'CONTAMINE(E)!',
        background: '#000000',
        imageUrl: image,
        text: 'Tu as pris beaucoup trop de risques, pas étonnant que tu sois en réa...',
        confirmButtonText: 'BeuuuBye !',
      })
    }
  }
};

export { popups };
