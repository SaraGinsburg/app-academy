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
    if !valid_play?(guess)
      @current_player.alert_invalid_guess
      return false
    else
      @fragment << guess
      return true
    end
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

      until take_turn
      end
      game_on = !check_win  
      next_player!
    end


  end


end


class Player

  attr_reader :name

  def initialize(name)
    @name = name
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
