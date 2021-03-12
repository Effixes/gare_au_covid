class EndGame
  def initialize(game)
    @game = game
    @player = @game.current_player
  end

  def call
    # fin de tour
    # compter le nombre de players alive
    # si le compte est a 1
    if @game.players.alive.count == 1
      @game.status = 'over'
    end
    # fin de partie player alive est le winner
    # status game over
    @game.save!
  end
end
