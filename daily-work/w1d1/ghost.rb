class Game
  attr_reader :players, :fragment, :dictionary, :current_player, :previous_player

  def initialize(players, fragment, dictionary)
    @players = players
    @fragment = fragment
    @dictionary = dictionary.to_set
    @current_player = @players[0]
    @previous_player = nil
  end

  def take_turn
    guess = @current_player.guess
    while !valid_play?(guess)
      @current_player.alert_invalid_guess
      guess = @current_player.guess
    end
    @fragment << guess
  end

  def valid_play?(string)
    word = @fragment + string
    dictionary.any? { |el| !(( /\A#{word}\w+/ =~ el ).nil?) }
  end

  def next_player!
    @previous_player = @current_player
    next_index = (@players.find_index(@current_player) + 1) % @players.length
    @current_player = @players[next_index]
  end

  def check_win
    dictionary.include?( @fragment)
  end

  def play_round
    game_on = true
    while game_on
      take_turn
      if check_win
        game_on = false
      else
        next_player!
      end
    end
    update_record
    print_score
  end

  def update_record
    @current_player.add_loss
    next_player!
  end

  def print_score
    puts "round over"
    @players.each{ |player| puts "#{player.name}: #{"GHOST"[0...player.losses]}" if player.losses < 5}
  end

end


class Player

  attr_reader :name, :losses

  def initialize(name)
    @name = name
    @losses = 0
  end

  def add_loss
    @losses += 1
  end

  def alert_invalid_guess
    puts "Invalid Guess"
  end

  def guess
    puts "Please guess a letter"
    guess = gets.chomp[0]
    guess
  end

end
