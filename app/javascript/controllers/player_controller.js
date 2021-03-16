import ApplicationController from './application_controller'
import CableReady from 'cable_ready'
import consumer from '../channels/consumer'

export default class extends ApplicationController {
  static values = { id: Number }

  connect () {


    console.log("coucou le chat",this.idValue)
    consumer.subscriptions.create(
      {
        channel: 'PlayerChannel',
        id: this.idValue
      },{
      received (data) {
        if (data.cableReady) CableReady.perform(data.operations)
      }
    })

  }
}

