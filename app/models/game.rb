class Game < ApplicationRecord
  belongs_to :host,           class_name: 'Player', optional: true, dependent: :destroy
  belongs_to :current_player, class_name: 'Player', optional: true, dependent: :destroy

  has_many :players, dependent: :destroy

  validates :status, inclusion: {in: ['waiting', 'on_going', 'over']}

  def next_player
    alive_players = players.where(alive: true).order(:table_position)
    next_player_index = (alive_players.index(current_player) + 1) % alive_players.lenght
    alive_players[next_player_index]
  end

  def start
    StartGame.new(self).call
  end
end
