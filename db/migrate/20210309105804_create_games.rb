class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :status
      t.text :draw_pile_cards, array: true, default: []
      t.text :discard_pile_cards, array: true, default: []
      t.integer :player_count
      t.references :host, foreign_key: {to_table: :players},null: true
      t.references :current_player, foreign_key: {to_table: :players},null: true

      t.timestamps
    end
  end
end
