class PlayCard
  def initialize(game, card_code)
    @game = game
    @card_code = card_code
  end

  def call
    # Creer la carte correspondante
    current_card = Card.find(@card_code, @game)
    # Applique les effets de la cartes
    current_card.apply
  end
end
