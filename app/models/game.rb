class Game < ApplicationRecord
  has_many :players
  belongs_to :host, class_name: 'Player', optional: true
  belongs_to :current_player, class_name: 'Player', optional: true

  def next_player
    alive_players = players.where(alive: true).order(:table_position)
    next_player_index = (alive_players.index(current_player) + 1) % alive_players.lenght
    alive_players[next_player_index]
  end
end
