require_relative 'display'

class Chess

  attr_reader :display, :board

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    until board.checkmate?
      display.grab_move
      switch_player!
    end
    end_game
  end

  private

  def switch_player!
    @board.switch_player!
  end

  def end_game
    display.render
    puts "Checkmate! #{@board.opposing_player.to_s.capitalize} wins!"
  end

end


game = Chess.new
game.play
