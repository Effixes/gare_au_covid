class EndTurn
  def initialize(game)
    @game = game
  end

  def call
    @game.current_player = @game.next_player
    @game.save!
  end
end

