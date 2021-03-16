class DrawCard
  def initialize(game)
    @game   = game
    @player = @game.current_player
  end

  def call
    drawed_cards = []

    if @game.draw_pile_cards.count < @player.draw_card_count
      refill_draw_pile_cards
    end

    @player.draw_card_count.times do
      # recuperer la draw pile
      # prendre la premiere carte
      # la supprimer de la draw pile
      drawed_card = @game.draw_pile_cards.shift
      # l'integrer dans le jeu du current_joueur
      @player.cards << drawed_card

      drawed_cards << drawed_card
    end

    @player.draw_card_count = 0

    @game.save
    @player.save

    drawed_cards
  end

  private

  def refill_draw_pile_cards
    # prendre la defausse
    # melanger defausse
    # ajouter ca a la pioche
    @game.draw_pile_cards += @game.discard_pile_cards.shuffle
    # supprimer la defausse
    @game.discard_pile_cards = []
    # enregistrer game
    @game.save

  end
end
