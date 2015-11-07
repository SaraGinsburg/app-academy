class King < SteppingPiece

  def initialize(board, position, color)
    super
  end

  def move_directions
    [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def to_sym
    :king
  end

end
