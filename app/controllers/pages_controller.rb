class PagesController < ApplicationController
  def home
    @game = Game.new
    @player = @game.players.new
  end


  def components
  end
end
