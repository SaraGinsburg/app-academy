require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.length
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    deal = []
    raise "not enough cards" if n > self.count
    n.times { deal << @cards.shift }
    deal
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end
end
