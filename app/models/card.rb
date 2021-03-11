class Card
  def self.find(code, game)
    case code
    when "cluster"
      Cards::Cluster.new(game)
    when "covid"
      Cards::Covid.new(game)
    when "kit"
      Cards::Kit.new(game)
    when "lock_down"
      Cards::LockDown.new(game)
    when "mix"
      Cards::Mix.new(game)
    when "pair_pangolins", "pair_teletravail", "pair_villageoise", "pair_masques", "pair_couvre_feu"
      Cards::Pair.new(game, code)
    when "testing"
      Cards::Testing.new(game)
    end
  end
end
