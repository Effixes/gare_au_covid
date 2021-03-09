class AddAvatarToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :avatar, :string
  end
end
