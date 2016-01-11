require_relative 'board'

class Display
  include Cursorable

  @@white = {pawn: "\u265F", knight: "\u265E", bishop: "\u265D",
    rook: "\u265C", queen: "\u265B", king: "\u265A"}

  @@black = {pawn: "\u2659", knight: "\u2658", bishop: "\u2657",
    rook: "\u2656", queen: "\u2655", king: "\u2654"}

  attr_reader :board, :cursor_pos
  attr_accessor :selected, :target

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = nil
    @target = nil
  end

  def render
    system("clear")
    puts "\#  0   1   2   3   4   5   6   7 "
    @board.grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each_with_index do |square, col_index|
        render_piece(square, row_index, col_index)
      end
      puts
    end
    unless board.checkmate?
      puts "\nUse the arrow keys, WASD, or vim to move, space or enter to confirm."
      print "Check! " if self.board.in_check?(board.opposing_player)
      print "It's #{board.current_player.to_s.capitalize}'s turn. \n"
    end
  end

  def render_piece(square, row_index, col_index)
    unless self.board.is_empty?(square)
      color_hash = square.color == :white ? @@white : @@black
    end

    #piece vs empty
    if square.is_a?(Piece)
      str = " #{color_hash[square.to_sym]}  "
    else
      str = "    "
    end

    #black vs white square
    if [row_index, col_index] == @cursor_pos
      background = :light_blue
    elsif (col_index + row_index).even?
      background = :light_black
    else
      background = :default
    end

    #selected
    if [row_index, col_index] == @selected
      background = :light_red
    end


    print str.colorize(background: background)
  end

  def grab_move
    begin
      self.selected, self.target = nil, nil

      while self.target.nil?
        self.render
        user_input = self.get_input

        if user_input
          if self.selected
            self.target = user_input
          else
            self.selected = user_input
          end
        end
      end

      board.move(selected, target)
    rescue NoPieceError => e
      handle_error(e)
      retry
    rescue InvalidDestinationError => e
      handle_error(e)
      retry
    rescue InvalidMoveError => e
      handle_error(e)
      retry
    rescue PieceColorError => e
      handle_error(e)
      retry
    rescue StillInCheckError => e
      handle_error(e)
      retry
    rescue MovedIntoCheckError => e
      handle_error(e)
      retry
    end
  end

  def handle_error(e)
    puts
    puts e.message
    puts "Please try again. (Press <enter> if to continue...)"
    gets.chomp
  end

end
