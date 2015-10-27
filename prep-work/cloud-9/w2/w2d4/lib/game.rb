require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  
  attr_reader :player_one, :player_two, :board, :current_player
  
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @current_player = @player_one
  end
  
  def board
    @board
  end
  
  def switch_players!
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end
  
  def play_turn
    board.place_mark(@current_player.get_move, @current_player.mark)
    switch_players!
  end
  
  def play
    until @board.over?
      play_turn
    end
  end
end
