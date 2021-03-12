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
    @player.draw_card_count = 1
    @player.save
    @game.current_player = @game.next_player
    @game.save!

  end
end
