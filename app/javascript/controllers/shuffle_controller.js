import ApplicationController from './application_controller';
import { gsap }              from "gsap";

export default class extends ApplicationController {
  static values = {
    cardCount: Number,
    playersCount: Number
  }

  static targets = ['deck', 'avatar']

  connect () {
    this.shuffleCards();

    // setTimeout(this.removeWrapper, 10000);
  }

  shuffleCards() {
    var cardCount = this.avatarTargets.length * 7;
    var cards = [];
    for(var i = 0; i < cardCount;  i++) {
      cards.push(i)
    }

    cards.forEach((n) => {
      var cardTmp = '<span class="player-card">' + n + '</span>';
      this.deckTarget.insertAdjacentHTML('beforeend', cardTmp);
    });

    this.avatarTargets;

    this.deckTarget;

    var avatarIndex = 0;
    const xTargets = [];
    const yTargets = [];
    while (cards.length > 0) {

      const targetPlayer = this.avatarTargets[avatarIndex];





      const xTarget = 0;
      const yTarget = 0;

      xTargets.push(xTarget);
      yTargets.push(yTarget);



      cards.pop();
      if ((avatarIndex + 1) >= this.avatarTargets.length) {
        avatarIndex = 0;
      } else {
        avatarIndex += 1;
      }
    };

    gsap.to(".player-card", {
      duration: 1,
      rotation: 90,
      y: gsap.utils.wrap(yTargets),
      x: gsap.utils.wrap(xTargets),
      stagger: 0.5
    });
  }

  removeWrapper() {
    this.element.remove()
  }
}

