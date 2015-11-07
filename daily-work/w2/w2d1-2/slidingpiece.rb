class SlidingPiece < Piece

  def initialize(board, position, color)
    super
  end

  def moves
    possible_next_moves = []

    self.move_directions.each do |direction|
      magnitude = 1
      possible_direction = true

      while possible_direction
        next_move = [position[0] + (magnitude * direction[0]), position[1] + (magnitude * direction[1])]

        if board.in_bounds?(next_move) && board[next_move].nil?
          possible_next_moves << next_move
          magnitude += 1
        else
          possible_next_moves << next_move if board.in_bounds?(next_move) && board[next_move].color != self.color
          possible_direction = false
        end

      end
    end

    possible_next_moves
  end


end
