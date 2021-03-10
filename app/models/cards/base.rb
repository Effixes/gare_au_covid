class Cards::Base

  def initialize(game)
    @game = game
    @current_player = @game.current_player
    @next_player = @game.next_player
  end

  def apply
    discard_effect
    current_player_effect
    next_player_effect
    draw_effect 
  
    @game.save
    @current_player.save
    @next_player.save
  end

  private 

  def discard_effect
  end

  def current_player_effect
  end

  def next_player_effect
  end

  def draw_effect
  end



end
