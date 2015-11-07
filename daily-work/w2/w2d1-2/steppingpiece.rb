class SteppingPiece < Piece

  def initialize(board, position, color)
    super
  end

  def moves
    possible_next_moves = []

    self.move_directions.each do |direction|
      next_move = [position[0] + direction[0], position[1] + direction[1]]

      if board.in_bounds?(next_move) && (board[next_move].nil? || board[next_move].color != self.color)
        possible_next_moves << next_move
      end
    end

    possible_next_moves
  end

end
