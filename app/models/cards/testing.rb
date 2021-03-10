class Cards::Testing < Cards::Base
  # Regarde les 3 premieres cartes de la pioche
  def current_player_effect
    @current_player.cards.delete_at(@current_player.cards.index('testing'))
  end

  def draw_effect
    @game.draw_pile_cards.first(3)
  end

  def discard_effect
    @game.discard_pile_cards << 'testing'
  end
end
