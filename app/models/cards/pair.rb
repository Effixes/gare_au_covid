class Cards::Pair

  # Aucun effet seul mais permet de voler une carte aleatoire si paire
  #
  def initialize(code)
    @code = code
  end

  def current_player_effect
    @current_player.cards.delete_at(@current_player.cards.index(@code))
    @current_player.cards.delete_at(@current_player.cards.index(@code))
  end

  def next_player_effect
    stolen_card = @next_player.cards.sample
    @current_player.cards << stolen_card
    @next_player.cards.delete_at(@next_player.cards.index(stolen_card))
  end


  def discard_effect
    discard_pile_cards << @code
  end
end

