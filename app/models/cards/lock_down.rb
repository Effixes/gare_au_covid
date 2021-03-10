# Define the different effect of the card:
# retire 1 au nombre de carte a piocher
class Cards::LockDown < Cards::Base
  # Effet sur le joueur suivant
  def next_player_effect
  end

  # Effet sur le joueur actuel
  def current_player_effect
    # Retire 1 au nombre de cartes a piocher du joueur en cours
    if @current_player.draw_card_count >= 1
      @current_player.draw_card_count -= 1
    end
    # Enleve une carte mixed de la main du joueur en cours
    @current_player.cards.delete_at(@current_player.cards.index("lock_down"))
  end

  # Effet sur la defausse
  def discard_effect
    @game.discard_pile_cards << "lock_down"
  end

  # Effet sur la pioche
  def draw_effect
  end
end
