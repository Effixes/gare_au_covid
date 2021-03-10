
# Define the different effect of the card:
# On melange la pioche
# Effet sur la main du joueur on retire la carte (cluster -1)
# Effet sur la defausse (cluster + 1)
# Effet sur la pioche ()
# joueur suivant pioche 2 fois a la fin du tour

class Cards::Mix < Cards::Base
  # Effet sur le joueur suivant
  def next_player_effect
  end

  # Effet sur le joueur actuel
  def current_player_effect
    @current_player.cards.delete_at(@current_player.cards.index("mixed"))
  end

  # Effet sur la pioche
  def draw_effect
    @game.draw_pile_cards.shuffle!
  end

  # Effet sur la defausse
  def discard_effect
    @game.discard_pile_cards << "mixed"
  end
end
