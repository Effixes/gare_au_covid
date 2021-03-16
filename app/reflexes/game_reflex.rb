# frozen_string_literal: true

class GameReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes
  before_reflex :set_game

  def draw
    drawed_card_codes = DrawCard.new(@game).call
    params[:drawed_card_codes] = drawed_card_codes
  end

  def end_turn
    EndTurn.new(@game).call
    EndGame.new(@game).call
  end

  def start
    if current_player == @game.host
      StartGame.new(@game).call
    else
      flash[:alert] = "En attente de la création de la partie"
    end
  end

  def play_card
    card_code = element.dataset[:card_code]
    PlayCard.new(@game, card_code).call
    params[:played_card_code] = card_code
  end

  private

  def set_game
    id = params[:id].presence || params[:game_id]

    @game = Game.find(id)

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
  end

  def player_has_not_joined_game?
    current_player.nil? || @game.player_ids.include?(current_player.id) == false
  end
end
