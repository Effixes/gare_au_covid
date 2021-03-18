import ApplicationController from './application_controller'

export default class extends ApplicationController {
  connect () {
    console.log('shuffle!')
    setTimeout(() => {
        this.element.remove();
    }, 4000)
  }
}

