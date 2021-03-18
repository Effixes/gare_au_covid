class StartGame
  # jeu sans covid et sans kit
  GAME_CARDS = {
    'cluster' => 5,
    'lock_down' => 5,
    'mix' => 5,
    'testing' => 5,
    'pair_pangolins' => 4,
    'pair_teletravail' => 4,
    'pair_villageoise' => 4,
    'pair_masques' => 4,
    'pair_couvre_feu' => 4
  }

  # Version pour test
  # GAME_CARDS = {
  #   'cluster' => 21
  # }

  def initialize(game)
    @game = game
  end

  def call
    setup_cards_and_positions
    # position du current_player
    set_current_player
    # statut du jeu : demarre
    mark_as_on_going

    @game.save
  end

  private

  def dispatch_cards
    # repartir cartes :
    covid_kit = {
      'kit' => 6 - @game.players_count,
      'covid' => @game.players_count
      # Version pour test mort rapide
      # 'kit' => 0,
      # 'covid' => 5
    }

    # un kit a chaque joueur
    @game.players.each do |player|
      player.cards << 'kit'
    end

    # melange jeu
    cards_temp = []

    GAME_CARDS.each do |card, number|
      number.times do
        cards_temp << card
      end
    end
    # melange jeu
    cards_temp.shuffle!

    # distrib aux joueurs 6 shuffles cards
    @game.players.each do |player|
      6.times do
        player.cards << cards_temp.shift
      end
    end

    # integrer covid + kit au jeu
    covid_kit.each do |card, number|
      number.times do
        cards_temp << card
      end
    end
    # melange jeu
    # le definir en tant que pioche
    @game.draw_pile_cards = cards_temp.shuffle
  end

  def initialize_players_position
    # definir table_position des players
    # melanger tableau de joueurs
    @shuffled_players = @game.players.shuffle
    # itirer sur chaque joueur index pour donner et sauver leur position
    @shuffled_players.each_with_index do |player, index|
      player.table_position = index
      player.save
    end
  end

  def set_current_player
    # position du current_player
    # definir player_position.first comme joueur -> @game.current_player
    @game.current_player = @shuffled_players.first
  end

  def mark_as_on_going
    # statut du jeu : demarre
    # passer le statut a on_going
    @game.status = 'on_going'
  end

  def setup_cards_and_positions
    if ENV['DEMO'] == "true"
      dispatch_cards_demo
      # definir table_position des players
      initialize_players_position_demo
      # Set current players
      set_current_player_demo
    else
      dispatch_cards
      # definir table_position des players
      initialize_players_position
      # Set current player
      set_current_player
    end
  end

  # Version pour la demo
  def dispatch_cards_demo
    # Initialise le jeu de chaque joueur

    # Jeu justine
    @game.players[0].cards = ['pair_villageoise', 'testing', 'lock_down', 'kit', 'pair_masques', 'pair_pangolins', 'mix']
    # Jeu Geoffrey
    @game.players[1].cards = ['testing', 'pair_pangolins', 'mix', 'kit', 'cluster', 'pair_teletravail', 'lock_down']
    # Initialise la pioche
    # Jeu allan
    @game.players[2].cards = ['testing', 'cluster', 'lock_down', 'mix', 'pair_teletravail', 'pair_masques', 'kit']
    @game.draw_pile_cards = ['pair_teletravail', 'mix', 'pair_pangolins', 'cluster', 'testing', 'covid', 'covid', 'cluster', 'pair_couvre_feu', 'covid', 'covid']
  end

  def initialize_players_position_demo
    # definir table_position des players
    # Ne melande pas le tableau de joueur
    @shuffled_players = @game.players.order(:created_at)
    # itirer sur chaque joueur index pour donner et sauver leur position
    @shuffled_players.each_with_index do |player, index|
      player.table_position = index
      player.save
    end
  end

  def set_current_player_demo
    # position du current_player
    # definir player_position.first comme joueur -> @game.current_player
    @game.current_player = @shuffled_players.last
  end
end
