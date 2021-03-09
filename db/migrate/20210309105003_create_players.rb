class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :alive, default: true
      t.text :cards, array: true, default: []
      t.integer :table_position
      t.integer :draw_card_count

      t.timestamps
    end
  end
end
