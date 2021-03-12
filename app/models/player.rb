class Player < ApplicationRecord
  AVATARS = ["nun.png", "batman.png", "harley.png", "indian_us", "jason.png", "sexy_man.png", "sheep.png", "sloth.png", "white.png", "wonderw.png"]

  belongs_to :game
end
