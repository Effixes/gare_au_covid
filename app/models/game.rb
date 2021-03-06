class Game < ApplicationRecord
  belongs_to :host,           class_name: 'Player', optional: true, dependent: :destroy
  belongs_to :current_player, class_name: 'Player', optional: true, dependent: :destroy

  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players

  validates :status, inclusion: {in: ['waiting', 'on_going', 'over']}

  def next_player
    alive_players = players.where(alive: true).order(:table_position)

    next_player   = alive_players.find { |player| player.table_position > current_player.table_position }
    next_player ||= alive_players.first
  end

  def start
    StartGame.new(self).call
  end

  def ordered_other_players(player)
    ordered_players  = players.order(:table_position)
    next_players     = ordered_players.drop(player.table_position + 1)
    previous_players = ordered_players.take(player.table_position)

    return next_players + previous_players
  end

  def over?
    players.alive.count == 1
  end
end
