class Knight < SteppingPiece

  def initialize(board, position, color)
    super
  end

  def move_directions
    [[1,2], [2,1], [-1,2], [-2,1], [1,-2], [2,-1], [-1,-2], [-2,-1]]
  end

  def to_sym
    :knight
  end

end
