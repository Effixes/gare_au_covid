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

  # # MEMO DIFF DES RENDER

  # # View
  # render partial: 'games/player_card', player: current_player
  # # Controller / Reflex
  # render(partial: 'games/player_card', locals: { player: current_player })

  # # Controller / (default) Reflex action
  # render 'games/on_going'
  # # render from Reflex
  # render(file: 'games/on_going', assigns: { game: @game, ... })

  before_reflex :set_game
  before_reflex :setup_game

  def start
    # current player action
    if current_player == @game.host
      StartGame.new(@game).call
    else
      flash[:alert] = "En attente de la création de la partie"
    end

    # prepare html data for other players
    current_player.reload # so that he/she has a table position
    @game.reload          # so that game status is up to date

    # broadcast to other players
    @game.players.each do |player|
      next if player == current_player

      assigns = setup_game(player)
      html    = render(file: 'games/on_going', layout: false, assigns: assigns)

      cable_ready[PlayerChannel].replace(selector: dom_id(@game), html: html).broadcast_to(player)
    end

    @current_player = current_player
  end

  def play_card
    card_code = element.dataset[:card_code]
    PlayCard.new(@game, card_code).call
    params[:played_card_code] = card_code

    # Prepare html data for other players
    current_player.reload # Reload for table position
    @game.reload          # game status is up to date

    # Broadcast to other players
    @game.players.each do |player|
      next if player == current_player

      assigns = setup_play_card(player)
      html    = render(file: 'games/on_going', layout: false, assigns: assigns)

      cable_ready[PlayerChannel].replace(selector: dom_id(@game), html: html).broadcast_to(player)
    end
    @current_player = current_player
  end

  def draw
    # current player action
    drawed_card_codes = DrawCard.new(@game).call
    params[:drawed_card_codes] = drawed_card_codes

    # Prepare html data for other players
    current_player.reload # Reload for table position
    @game.reload          # game status is up to date

    # broadcast to other players
    @game.players.each do |player|
      next if player == current_player

      assigns = setup_play_card(player)
      html    = render(file: 'games/on_going', layout: false, assigns: assigns)

      cable_ready[PlayerChannel].replace(selector: dom_id(@game), html: html).broadcast_to(player)
    end
    @current_player = current_player
  end

  def end_turn
    # current player action
    EndTurn.new(@game).call
    EndGame.new(@game).call

    # Prepare html data for other players
    current_player.reload # Reload for table position
    @game.reload          # game status is up to date

    # broadcast to other players
    @game.players.each do |player|
      next if player == current_player

      assigns = setup_play_card(player)
      html    = render(file: 'games/on_going', layout: false, assigns: assigns)

      cable_ready[PlayerChannel].replace(selector: dom_id(@game), html: html).broadcast_to(player)
    end
    @current_player = current_player
  end

  private

  def set_game
    id = params[:id].presence || params[:game_id]

    @game = Game.find(id)
  end

  # we need to pass player as argument as current_player is found from session[:player_id]
  def setup_game(player = current_player)
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
      @ordered_players = @game.ordered_other_players(player)
    end
    @current_player = player
    # to pass them to render WTF....
    return { game: @game, ordered_players: @ordered_players, current_player: @current_player, curent_status: @curent_status }
  end

  # we need to pass player as argument as current_player is found from session[:player_id]
  def setup_play_card(player = current_player)

    # Gestion affichage joueur ordonner
    @ordered_players = @game.ordered_other_players(player)
    @current_player = player
    # return { game: @game, ordered_players: @ordered_players, params: { played_card_code: card_code } }
    return { game: @game, ordered_players: @ordered_players, current_player: @current_player }
  end

  def player_has_not_joined_game?
    current_player.nil? || @game.player_ids.include?(current_player.id) == false
  end
end
