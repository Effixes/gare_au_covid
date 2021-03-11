module CardHelper
  def playable?(card_code)
    # Recupere le jeu en cours

    case card_code
    # cluster
    when "cluster"
      # Tout le temps jouable
      true
    # Mix
    when "mix"
      # Tout le temps jouable
      true
    when "testing"
      # Tout le temps jouable
      true

    # Lock down
    when "lock_down"
      # Carte jouable si nomnbre de carte a piocher >= 1
      current_player.draw_card_count >= 1

    # Pairs
    when "pair_pangolins", "pair_teletravail", "pair_villageoise", "pair_masques", "pair_couvre_feu"
      # Init compteur
      count_pair = current_player.cards.count { |card| card == card_code }
      count_pair >= 2
    end

    true
  end
end
