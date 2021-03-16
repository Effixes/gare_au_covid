const Swal = require('sweetalert2')

const looser = () => {

  let myTurn = document.getElementById('myturn');

  if (myTurn) {
    const alive = myTurn.dataset.alive

    if (alive == 'false') {

      Swal.fire({
        title: 'CONTAMINE(E)!',
        background: '#000000',
        imageUrl: 'http://www.gare-au-covid.com/assets/covid_illustration-9bc6256ceeb24384b1b4b23dab394e401f64b90d1c5183e05541affca8bb8bcc.png',
        text: 'Tu as pris beaucoup trop de risques, pas étonnant que tu sois en réa...',
        confirmButtonText: 'BeuuuBye !',
      })
    }
  }
};

export { looser };
