class Rook < SlidingPiece

  def initialize(board, position, color)
    super
  end

  def move_directions
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def to_sym
    :rook
  end

end
