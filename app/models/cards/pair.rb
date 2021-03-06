class Cards::Pair < Cards::Base

  # Aucun effet seul mais permet de voler une carte aleatoire si paire
  #
  def initialize(game, code)
    super(game)
    @code = code
  end

  def current_player_effect
    @current_player.cards.delete_at(@current_player.cards.index(@code))
    @current_player.cards.delete_at(@current_player.cards.index(@code))
  end

  def next_player_effect
    # Verify si le joueur suivant a des cartes
    if @next_player.cards.count > 0
      stolen_card = @next_player.cards.sample
      @current_player.cards << stolen_card
      @next_player.cards.delete_at(@next_player.cards.index(stolen_card))
    end
  end

  def discard_effect
    @game.discard_pile_cards << @code
    @game.discard_pile_cards << @code
  end
end
