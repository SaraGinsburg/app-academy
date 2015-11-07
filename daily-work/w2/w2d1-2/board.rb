require_relative 'dependencies'

class Board
  attr_accessor :grid
  attr_reader :current_player, :opposing_player

  NIL_ROW = Array.new(8){ nil }
  PAWN_ROW = Array.new(8){ :pawn }
  PIECE_ROW = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]
  DEFAULT_BOARD = [PIECE_ROW, PAWN_ROW, NIL_ROW, NIL_ROW, NIL_ROW, NIL_ROW, PAWN_ROW, PIECE_ROW]

  def initialize
    @grid = generate_board
    @current_player = :white
    @opposing_player = :black
  end

  def switch_player!
    @current_player, @opposing_player = @opposing_player, @current_player
  end

  def self.empty_board
    board = Board.new()
    board.grid = []
    board
  end

  def copy_board(copy)
    new_board = self.class.empty_board
    new_grid = []

    copy.each_with_index do |row, row_i|
      new_row = []

      row.each_with_index do |square, col_i|
        unless is_empty?(square)
          new_row << new_piece(new_board, square.to_sym, [row_i, col_i], square.color)
        else
          new_row << nil
        end
      end

      new_grid << new_row
    end

    new_board.grid = new_grid
    new_board
  end

  def generate_board
    new_board = []
    current_color = :white

    DEFAULT_BOARD.each_with_index do |row, row_index|
      new_row = []

      if row_index.between?(2,5)
        new_row = Array.new(8){ nil }
      else
        current_color = :black if row_index > 3

        row.each_with_index do |piece, col_index|
          new_row << new_piece(self, piece, [row_index, col_index],current_color)
        end
      end

      new_board << new_row
    end
    new_board
  end

  def valid_move?(start_pos, end_pos)
    self[start_pos].moves.include?(end_pos)
  end

  def in_check?(color)
    king = nil
    possible_moves = []

    opp_color = color == :white ? :black : :white

    self.grid.flatten.each do |square|
      next if is_empty?(square)
      if square.color == opp_color && square.is_a?(King)
        king = square
      elsif square.color == color
        possible_moves += square.moves
      end
    end

    possible_moves.include?(king.position)
  end

  def checkmate?
    self.grid.each do |row|
      row.each do |square|
        next if is_empty?(square) || square.color == @opposing_player

        square.moves.each do |next_move|
          return false if !move_in_check?(square.position, next_move)
        end

      end
    end
    true
  end

  def move_in_check?(start_pos, end_pos)
    new_board = copy_board(@grid)
    new_board.move!(start_pos, end_pos)
    new_board.in_check?(@opposing_player)
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos].position = end_pos
    self[start_pos] = nil
  end

  def move(start_pos, end_pos)

    raise NoPieceError, "You can't move an empty tile!" unless has_piece?(start_pos)
    raise InvalidDestinationError, "You can't capture your own piece!" unless valid_end_position?(end_pos)
    raise PieceColorError, "That's not your piece!" unless self[start_pos].color == @current_player
    raise InvalidMoveError, "That piece cannot do that!" unless valid_move?(start_pos, end_pos)
    raise StillInCheckError, "You gotta move out of check, bro!" if move_in_check?(start_pos, end_pos) && in_check?(@opposing_player)
    raise MovedIntoCheckError, "You can't move into check, bro!" if move_in_check?(start_pos, end_pos)

    move!(start_pos, end_pos)
  end

  def valid_end_position?(end_position)
    in_bounds?(end_position) &&
    (!has_piece?(end_position) || self[end_position].color == @opponent)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def is_empty?(square)
    square.nil?
  end

  def has_piece?(position)
    self[position].is_a?(Piece)
  end

  def [](pos)
    grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    grid[pos[0]][pos[1]] = value
  end

  def new_piece(board, name, position, color)
    case name
    when :pawn
      Pawn.new(board, position, color)
    when :rook
      Rook.new(board, position, color)
    when :knight
      Knight.new(board, position, color)
    when :bishop
      Bishop.new(board, position, color)
    when :queen
      Queen.new(board, position, color)
    when :king
      King.new(board, position, color)
    else
      nil
    end
  end


end
