import ApplicationController from './application_controller';
import { gsap }              from "gsap";

export default class extends ApplicationController {
  static values = {
    cardCount: Number,
    playersCount: Number
  }

  static targets = ['deck', 'avatar']

  connect () {
    this.wrapper = this.element
    this.shuffleCards();
  }

  shuffleCards() {
    var cardCount = this.avatarTargets.length * 7;
    var cards = [];
    for(var i = 0; i < cardCount;  i++) {
      cards.push(i)
    }

    cards.forEach((n) => {
      var cardTmp = '<span class="player-card"></span>';
      this.deckTarget.insertAdjacentHTML('beforeend', cardTmp);
    });

    //this.avatarTargets.forEach(avatar => console.log("Avatar" + avatar.offsetLeft));

    var avatarIndex    = 0;
    const xTargets     = [];
    const yTargets     = [];
    const deckBoudings = this.deckTarget.getBoundingClientRect();

    while (cards.length > 0) {

      const targetPlayer   = this.avatarTargets[avatarIndex];
      // const playerBoudings = targetPlayer.getBoundingClientRect();
      const { x, y, right, left, top, bottom } = targetPlayer.getBoundingClientRect();

      const xTarget = x - deckBoudings.x + (right - left);
      const yTarget = y - deckBoudings.y  + (bottom - top);


      xTargets.push(xTarget);
      yTargets.push(yTarget);


      // this.avatarTargets.forEach(function(avatar) {
      //   //yTargets.push(avatar.offsetTop);
      //   //console.log(avatar.offsetLeft);
      //   xTargets.push(avatar.offsetLeft);
      //   xTargets.push(avatar.offsetTop);
      // });

      //yTargets.push(yTarget);

      cards.pop();

      if ((avatarIndex + 1) >= this.avatarTargets.length) {
        avatarIndex = 0;
      } else {
        avatarIndex += 1;
      }

      if (cards.length === 0) { break; }
    };

    const toto = gsap.to(".player-card", {
      duration: 1,
      rotation: 360,
      y: gsap.utils.wrap(yTargets),
      x: gsap.utils.wrap(xTargets),
      stagger: 0.5
    }).eventCallback("onComplete", this.removeWrapper);
  }

  removeWrapper() {
    const wrapper = document.querySelector('[data-controller="shuffle"]');
    wrapper.classList.add('no-opacity');
    setTimeout(() => {
      wrapper.remove()
    }, 1000);
  }
}

