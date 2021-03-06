class EndTurn
  def initialize(game)
    @game = game
    @player = @game.current_player
  end

  def call
    # si covid dans player_cards alors apply covid
    # -- si kit apply kit
    #
    if @player.cards.include?('covid')
      covid_card = Card.find('covid', @game)
      covid_card.apply
      if @player.cards.include?('kit')
        kit_card = Card.find('kit', @game)
        kit_card.apply
      end
    end

    if @player.alive
      @player.draw_card_count = 1
    # si player dead il faut balancer ses cartes dans la discard_pile
    else
      @game.discard_pile_cards += @player.cards
      @player.cards = []
    end

    # test du nombre de joueurs pour passer au end_game si 1 seul joueur
    survivors = @game.players.where(alive: true)

    if survivors.count > 1
      @game.current_player = @game.next_player
    end

    @player.save!
    @game.save!
  end
end


