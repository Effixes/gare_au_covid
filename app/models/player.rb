class Player < ApplicationRecord
  belongs_to :games
  has_one_attached :avatar
end
