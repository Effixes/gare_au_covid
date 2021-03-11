class PlayersController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @player = Player.new(player_params)
    @player.game = @game
    if @player.save
      set_current_player(@player)
      redirect_to game_path(@game)
    end
  end

      private

      def player_params
        params.require(:player).permit(:name, :avatar)
      end
end
