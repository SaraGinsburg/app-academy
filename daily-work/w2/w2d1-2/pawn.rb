  class Pawn < SteppingPiece

  attr_reader :initial_position

  def initialize(board, position, color)
    @initial_position = position
    super
  end

  def moves
    direction = color == :white ? 1 : -1
    moves = []

    # UP 1
    next_move = [position[0] + 1 * direction, position[1]]
    moves << next_move if board.in_bounds?(next_move) && board[next_move].nil?

    #UP 2- only on first move
    next_move = [position[0] + 2 * direction, position[1]]
    moves << next_move if has_not_moved? && board[next_move].nil?

    #UP and RIGHT- only to capture
    next_move = [position[0] + 1 * direction, position[1] + 1]
    moves << next_move if board.in_bounds?(next_move) && board[next_move] && board[next_move].color != self.color

    #UP and LEFT- only to capture
    next_move = [position[0] + 1 * direction, position[1] - 1]
    moves << next_move if board.in_bounds?(next_move) && board[next_move] && board[next_move].color != self.color

    moves
  end

  def has_not_moved?
    initial_position == position
  end

  def to_sym
    :pawn
  end


end

# possible_next_moves = []
# self.move_directions.each do |direction|
#   next_move = [position[0] + direction[0], position[1] + direction[1]]
#   if (board[next_move].nil? && board.in_bounds?(next_move)) || board[next_move].color != self.color
#     possible_next_moves << next_move
#   end
# end
# possible_next_moves
