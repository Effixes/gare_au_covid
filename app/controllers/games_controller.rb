class GamesController < ApplicationController
  before_action :set_game, only: :show

  def show
    @curent_status =
    if @game.status == 'waiting' && player_has_not_joined_game?
        'player_invited'
      elsif @game.status == 'waiting'
        'waiting'
      else
        'on_going'
      end

      render @curent_status
    end

    def create
      @game = Game.new(game_params)
      @game.status = "waiting"
      @game.host = @game.players.first
      @game.save!
      set_current_player(@game.players.first)
      redirect_to game_path(@game)
    end





    def play_card(card_code)
      PlayCard.new(@game, card_code).call
    end

    private

    def player_has_not_joined_game?
      current_player.nil? || @game.player_ids.include?(current_player.id) == false
    end

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:players_count, players_attributes: [:name, :avatar])
    end
end
