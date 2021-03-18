class Player < ApplicationRecord
  AVATARS = ["nun.png", "batman.png", "harley.png", "indian_us.png", "jason.png", "sexy_man.png", "sheep.png", "sloth.png", "white.png", "wonderw.png"]

  belongs_to :game

  scope :alive, -> { where(alive: true)}
  before_create :set_default_avatar

  private

  def set_default_avatar
    return if avatar.present?

    assign_attributes(avatar: AVATARS.sample)
  end
end
