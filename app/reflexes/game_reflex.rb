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
  before_reflex :setup_game, only: [:start]
  before_reflex :set_player_name

  def start
    # current player action
    if current_player == @game.host
      StartGame.new(@game).call
    else
      return flash[:alert] = "En attente de la cr??ation de la partie"
    end

    @game.reload

    @game.players.each do |player|
      player.reload
      html = render(partial: 'games/board', locals: partial_locals(player))

      shuffling_cards_partial = render(partial: 'games/shuffle_start', locals: partial_locals(player))

      cable_ready[PlayerChannel].inner_html(selector: dom_id(player), html: html).
        insert_adjacent_html(selector: dom_id(@game), html: render(partial: 'games/rules'), position: 'afterend').
        insert_adjacent_html(selector: dom_id(@game), html: shuffling_cards_partial, position: 'afterend').
        remove_css_class(selector: dom_id(@game), name: "waiting-wrapper").broadcast_to(player)

    end

    morph :nothing
  end

  def play_card
    # current player action
    card_code = element.dataset[:card_code]
    PlayCard.new(@game, card_code).call
    params[:played_card_code] = card_code

    # last_action_player
    params[:last_action] = "#{@player_name} a jou?? la carte : #{Card.name(card_code)}"

    # Broadcast new board to players
    broadcast_board_to_players
  end

  def draw
    # current player action
    drawed_card_codes = DrawCard.new(@game).call
    params[:drawed_card_codes] = drawed_card_codes

    # last_action_player
    draw_card_last_action

    # Broadcast new board to players
    broadcast_board_to_players
  end

  def end_turn
    # current player action
    player    = @game.current_player
    has_covid = player.cards.include?('covid')

    EndTurn.new(@game).call
    EndGame.new(@game).call


    # last_action_player
    end_turn_message(player, has_covid)

    # Broadcast new board to players
    broadcast_board_to_players
  end

  private

  def set_game
    id = params[:id].presence || params[:game_id]

    @game = Game.find(id)
  end

  def set_player_name
    @player_name = @game.current_player&.name
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
  def partial_locals(player = current_player)
    # Gestion affichage joueur ordonner
    @ordered_players = @game.ordered_other_players(player)

    return { game: @game, ordered_players: @ordered_players, board_player: player, params: params }
  end

  def player_has_not_joined_game?
    current_player.nil? || @game.player_ids.include?(current_player.id) == false
  end

  def broadcast_board_to_players
    @game.reload

    @game.players.each do |player|
      player.reload
      html = render(partial: 'games/board', locals: partial_locals(player))
      cable_ready[PlayerChannel].inner_html(selector: dom_id(player), html: html).broadcast_to(player)
    end

    morph :nothing
  end

  def draw_card_last_action
    if params[:drawed_card_codes].include?("covid")
      return params[:last_action] = "#{@player_name} a chopp?? la Covid !!!"
    end

    params[:last_action] = "#{@player_name} a pioch?? #{helpers.pluralize(params[:drawed_card_codes].length, "carte")} !"
  end

  def end_turn_message(player, has_covid)
    player.reload

    if has_covid && player.alive?
      return params[:last_action] = "Mais #{@player_name} avait un kit !!"
    elsif player.alive?
      return params[:last_action] = "#{@player_name} a fini son tour !"
    end

    params[:last_action] = "#{@player_name} est infect?? !!!"
  end
end
