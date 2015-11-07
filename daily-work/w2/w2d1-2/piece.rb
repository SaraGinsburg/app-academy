require_relative 'board'

class Piece
  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def moves
    raise "Not Implemented"
  end

  def to_s
    raise "Not Implemented"
  end

  def to_sym
    raise "Not Implemented"
  end

end
