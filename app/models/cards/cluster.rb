
# Define the different effect of the card:
# Le prochaine joueur pioche 2 fois a son tour
# Effet sur la main du joueur on retire la carte (cluster -1)
# Effet sur la defausse (cluster + 1)
# Effet sur la pioche ()
# joueur suivant pioche 2 fois a la fin du tour
class Cards::Cluster < Cards::Base
  # Effet sur le joueur suivant
  def next_player_effect
    # le prochain joueur pioche deux fois
    @next_player.draw_card_count += 1
  end

  # Effet sur le joueur actuel
  def current_player_effect
    # Enleve une carte cluster de la main du joueur
    @current_player.cards.delete_at(@current_player.cards.index("cluster"))
  end

  # Effet sur la pioche
  def draw_effect
    # Supprime la carte de la pioche
    # Game.draw_pile_cards.delete("cluster")
  end

  # Effet sur la defausse
  def discard_effect
    @game.discard_pile_cards << "cluster"
  end
end
