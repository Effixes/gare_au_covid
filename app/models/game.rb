class Game < ApplicationRecord
  has_many :players
  belongs_to :host_id, class_name: 'Player', optional: true
  belongs_to :current_player_id, class_name: 'Player', optionnal: true
end
