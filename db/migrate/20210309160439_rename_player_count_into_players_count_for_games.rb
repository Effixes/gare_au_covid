class RenamePlayerCountIntoPlayersCountForGames < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :player_count, :players_count
  end
end
