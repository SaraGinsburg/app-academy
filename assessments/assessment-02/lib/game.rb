class Game
  # deal players cards in an alternating pattern
  # return instance of Game
  def self.deal_in_players(deck)
    p1_cards, p2_cards = [], []
    p1_turn = false

    deck.each do |card|
      if p1_turn
        p1_cards << card
      else
        p2_cards << card
      end
      p1_turn = !p1_turn
    end

    Game.new(AIPlayer.new(p1_cards),AIPlayer.new(p2_cards))
  end

  def initialize(player1, player2)
    @player_1 = player1
    @player_2 = player2
  end

  # call do_battle until game is over
  def play

    until game_over?
      do_battle()
    end
  end

  # 1. Players each take their top card and lay it face UP.
  # 2. If the cards' rank is the same i.e. 3 of clubs and 3 of hearts,
  #    players take ANOTHER card and lay it face DOWN, then repeat step 1.
  # 3. If the last drawn cards are different ranks, all the cards drawn in
  #    this round are awarded to the drawer of the higher ranked card.
  def do_battle(prisoners = [])
    return if @player_1.out_of_cards? || @player_2.out_of_cards?

    winner = false

    begin
    until winner

      p1_card = @player_1.take_card
      p2_card = @player_2.take_card


      prisoners << p1_card
      prisoners << p2_card

      comp = p1_card <=> p2_card

      if comp == -1
        @player_2.give_won_cards(prisoners)
        winner = true

      elsif comp == 1
        @player_1.give_won_cards(prisoners)
        winner = true

      else
        prisoners << @player_1.take_card
        prisoners << @player_2.take_card
      end
    end
    rescue OutOfCardsError
    end
  end

  # if either of the players has run out of cards, the game is over
  def game_over?
    @player_1.out_of_cards? || @player_2.out_of_cards?
  end
end
