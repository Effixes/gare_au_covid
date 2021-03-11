  class PlayedCardsController < ApplicationController
    def create
      @game = Game.find(params[:game_id])
      PlayCard.new(@game, params[:card_code]).call
    end
  end
