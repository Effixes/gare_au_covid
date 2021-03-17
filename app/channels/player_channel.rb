class PlayerChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for Player.find(params[:id])
  end
end
