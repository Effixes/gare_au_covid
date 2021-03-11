class DrawCard
  def initialize(game)
    @game   = game
    @player = @game.current_player
  end

  def call
    if @player.draw_card_count > 0
    # recuperer la draw pile
    # prendre la premiere carte
    # la supprimer de la draw pile
    drawed_card = @game.draw_pile_cards.shift
    # l'integrer dans le jeu du current_joueur
    @player.cards << drawed_card
    @player.draw_card_count -= 1

    @game.save
    @player.save

    drawed_card
    end
  end
end
