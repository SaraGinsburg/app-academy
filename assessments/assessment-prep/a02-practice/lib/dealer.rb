require_relative 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet"
  end

  def play_hand(deck)
    until self.hand.points >= 17
      self.hand.hit(deck)
    end
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    @bets.each do |plr, amt|
      plr.pay_winnings(amt * 2) if plr.hand.beats?(self.hand)
    end
    nil
  end
end
