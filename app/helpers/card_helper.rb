module CardHelper
  def playable?(card_code, player)
    return false if player.draw_card_count == 0

    # Recupere le jeu en cours

    case card_code
    # Kit
    when "kit"
      false
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
      player.draw_card_count >= 1

    # Pairs
    when "pair_pangolins", "pair_teletravail", "pair_villageoise", "pair_masques", "pair_couvre_feu"
      # Init compteur
      count_pair = player.cards.count { |card| card == card_code }
      count_pair >= 2
    else
      true
    end
  end
end
