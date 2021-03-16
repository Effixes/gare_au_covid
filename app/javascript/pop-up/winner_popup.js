const Swal = require('sweetalert2')

const winner = () => {

  let myTurn = document.getElementById('myturn');

  if (myTurn) {
    const winner = myTurn.dataset.winner

    if (winner == 'true') {
      Swal.fire({
        title: 'WINNER!',
        background: '#000000',
        imageUrl: 'http://www.gare-au-covid.com/assets/covid_illustration-9bc6256ceeb24384b1b4b23dab394e401f64b90d1c5183e05541affca8bb8bcc.png',
        text: 'Yeahhh, malgré quelques écarts, tu as réussi à éviter la COVID...',
        // icon: 'error',
        // confirmButton:
        confirmButtonText: 'Nouvelle partie ?',
      })
    }
  }
};

export { winner };
