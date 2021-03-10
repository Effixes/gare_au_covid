class Player < ApplicationRecord
  AVATARS = ["avatar1", "avatar2"] 

  belongs_to :game
end
