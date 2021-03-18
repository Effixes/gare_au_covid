class PlayersController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @player = Player.new(player_params)
    @player.game = @game
    if @player.save
      set_current_player(@player)

      inform_host

      redirect_to game_path(@game)
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :avatar)
  end

  def inform_host
    html = render_to_string(partial: 'games/waiting_room', locals: {
      current_player: @game.host,
      game:           @game
    })

    cable_ready[PlayerChannel].
        replace(selector: dom_id(@game.host), html: html).
        broadcast_to(@game.host)
  end
end
