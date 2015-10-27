class BattleshipGame
  attr_reader :board, :player
  
  def initialize(player, board)
    @player = player
    @board = board
  end
  
  def attack(pos)
    @board.set_pos(pos[0],pos[1],:x)
  end
  
  def count
    @board.count
  end
  
  def game_over?
    @board.won?
  end
  
  def play_turn
    valid_guess = false
    while !valid_guess
      guess = @player.get_play
      
      if !@board.in_range(guess)
      
        puts "guess out of range- try again"
      
      elsif !@board.empty?(guess)
      
        attack(guess)
        puts "you missed"
        valid_guess = true
      
      elsif @board[guess] == :x
      
        puts "you already guessed that location- try again"
      
    else
      
        attack(guess)
        puts "hit!"
        valid_guess = true
        
      end
    end
  end
  
  def play
    puts "welcome to battlehsip"
    until game_over?
      play_turn
    end
    puts "you won!"
  end
  
  
  
end


if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end