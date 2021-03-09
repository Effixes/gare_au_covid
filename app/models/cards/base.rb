class Cards::Base

  def intitialize(game)
    @game = game
    @current_player = @game.current_player
    @next_player = @game.next_player
  end

  def apply

    discard_effect
    current_player_effect
    next_player_effect
    draw_effect

  end

end
