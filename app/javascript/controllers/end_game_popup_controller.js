const Swal = require('sweetalert2')
import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect() {
    const image    = this.element.dataset.image;
    const alive    = this.element.dataset.alive;
    const winner   = this.element.dataset.winner;
    const gameOver = this.element.dataset.gameOver;

    // j'ai gagne la partie
    if (winner == 'true') {
      Swal.fire({
        title: 'WINNER !',
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
        title: 'GAME OVER !!!!',
        background: '#000000',
        imageUrl: image,
        text: 'NOOON tu es contaminé(e) et pire que ça la partie est maintenant terminée !',
        confirmButtonText: 'Nouvelle partie ?',
      })
    }
    // J'ai perdu (COVID), le jeu est en cours
    else if (alive == 'false') {
      Swal.fire({
        title: 'CONTAMINE(E) !',
        background: '#000000',
        imageUrl: image,
        text: 'Tu as pris beaucoup trop de risques, pas étonnant que tu sois en réa...',
        confirmButtonText: 'BeuuuBye !',
      })
    }
  }
}
