class DrawCard
  def initialize(game)
    @game = game
    @player = @game.current_player
    @draw_pile_cards = @game.draw_pile_cards
  end

  def call
    # recuperer la draw pile
    # prendre la premiere carte
    # la supprimer de la draw pile
    drawed_card = @draw_pile_cards.shift
    # l'integrer dans le jeu du current_joueur
    @player.cards << drawed_card
    @game.save
    @player.save

    drawed_card
  end
end
