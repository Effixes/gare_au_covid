class Player < ApplicationRecord
  AVATARS = ["nun.png", "batman.png", "harley.png", "indian_us.png", "jason.png", "sexy_man.png", "sheep.png", "sloth.png", "white.png", "wonderw.png"]

  belongs_to :game

  scope :alive, -> { where(alive: true)}
end
