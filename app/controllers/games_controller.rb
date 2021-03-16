class GamesController < ApplicationController
  before_action :set_game, only: [:show, :draw, :start, :end_turn]

  def show
    @curent_status =
      if @game.status == 'waiting' && player_has_not_joined_game?
        'player_invited'
      elsif @game.status == 'waiting'
        'waiting'
      else
        'on_going'
      end
    # creation joueur
    @player = Player.new

    # Gestion affichage joueur ordonner
    if @curent_status == 'on_going'
      @ordered_players = @game.ordered_other_players(current_player)
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

  def start
    if current_player == @game.host
      StartGame.new(@game).call
    else
      flash[:alert] = "En attente de la création de la partie"
    end
    redirect_to game_path(@game)
  end

  def draw
    drawed_card_codes = DrawCard.new(@game).call
    redirect_to game_path(@game, drawed_card_codes: drawed_card_codes)
  end

  def end_turn
    EndTurn.new(@game).call
    EndGame.new(@game).call
    redirect_to game_path(@game)
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
