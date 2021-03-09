class ChangeDrawCardCountDefaultForPlayers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :players, :draw_card_count, from: nil, to: 1
  end
end
