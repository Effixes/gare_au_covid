
# Kit pioche : no effect,
# Kit - 1 dans draw_pile
# Debut du tour next_player
class Cards::Kit < Cards::Base

  def current_player_effect

    @current_player.cards.delete_at(@current_player.cards.index('kit'))
  end

end
