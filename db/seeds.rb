puts "Cleaning database..."

Game.all.each do |game|
  game.update(host: nil, current_player: nil)
  game.destroy
end

puts "Creating one game..."
game      = Game.new(status: 'waiting', players_count: 4)
allan     = game.players.new(name: 'allan')
game.host = allan
game.save

geoffrey = Player.create!(name:"geoffrey", game: game)
cecile   = Player.create!(name:"cecile", game: game)
justine  = Player.create!(name:"justine", game: game)

puts "Finished!"
