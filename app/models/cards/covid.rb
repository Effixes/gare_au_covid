# Covid piochee : partie terminee si le joueur n'a pas de kit sanitaire,
# Si kit sanitaire : Reste en partie,
# Kit sanitaire supprime du jeu
# Covid + 1 aleatoire dans draw_pile
# Toute la main sans le covid(supprime) Covid -1,
# Debut du tour next_player
class Cards::Covid < Cards::Base

  def current_player_effect
    unless @current_player.cards.include?('kit')
      @current_player.alive = false
    end
    # supprimer covid card de la main du player
    @current_player.cards.delete_at(@current_player.cards.index('covid'))
  end

  def draw_effect
    @game.draw_pile_cards.insert(rand(0...@game.draw_pile_cards.length), 'covid')
  end
end
