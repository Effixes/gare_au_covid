class Game < ApplicationRecord
  has_many :players
  belongs_to :host, class_name: 'Player', optional: true
  belongs_to :current_player, class_name: 'Player', optional: true

  def next_player
    alive_players = players.where(alive: true).order(:table_position)
    next_player_index = (alive_players.index(current_player) + 1) % alive_players.lenght
    alive_players[next_player_index]
  end

  def start
    # repartir cartes

    # definir table_position des players

    # position du current_player

    # statut du jeu : demarre
  end

  private
    def cards_dispatch
    # repartir cartes :

    # un kit a chaque joueur

    # jeu sans covid
    # melange jeu
    # distrib aux joueurs
    # integrer covid
    # melange jeu


    end

    def initialize_player_position
    # definir table_position des players
      # melanger tableau de joueurs
    end

    def current_player_position
    # position du current_player

    end

    # statut du jeu : demarre



end
