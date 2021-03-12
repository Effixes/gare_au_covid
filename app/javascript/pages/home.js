const updateHomeCounter = () => {
    let count = 1;
    const countEl = document.getElementById("game_players_count");
    let plus = document.getElementById("plus");
    let minus = document.getElementById("minus");

    if (plus) {
      plus.addEventListener("click", function(){
          count++;
          countEl.value = count;
      });
    }

    if (minus) {
      minus.addEventListener("click", function(){
          if (count > 1) {
              count--;
              countEl.value = count;
          }
      });
    }
}

export { updateHomeCounter };
