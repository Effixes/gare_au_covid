  class PlayedCardsController < ApplicationController
    def create
      @game = Game.find(params[:game_id])
      PlayCard.new(@game, params[:card_code]).call
      redirect_to game_path(@game, played_card_code: params[:card_code])
    end
  end
