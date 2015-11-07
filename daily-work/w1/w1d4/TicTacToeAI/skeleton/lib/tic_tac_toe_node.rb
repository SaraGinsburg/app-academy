require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #base case
    if @board.over?
      if @board.winner == opposite_mark(evaluator)
        return true
      else
        return false
      end
    end

    #recursive case
    no_wins = true
    children.each do |child|
      unless child.losing_node?(evaluator)
        no_wins = false
      else
        return true if child.children.any? do |grand_child|
          grand_child.losing_node?(evaluator)
        end
      end
    end
    no_wins
  end

  def winning_node?(evaluator)
    #base case
    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end

    #recusive case
    all_wins = true
    children.each do |child|
      if child.winning_node?(evaluator)
        return true
      else
        win_forced = child.children.all? do |grand_child|
          grand_child.winning_node?(evaluator)
        end

        all_wins = false unless win_forced
      end
    end
    all_wins
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    @board.rows.each_with_index do |row, row_i|
      row.each_with_index do |box, col_i|
        pos = [row_i, col_i]
        if @board.empty?(pos)
          possible_next_board = @board.dup
          possible_next_board[pos] = @next_mover_mark
          new_node = TicTacToeNode.new(possible_next_board, opposite_mark(@next_mover_mark),pos)
          result << new_node
        end
      end
    end
    result
  end


  def opposite_mark(mark)
    mark == :o ? :x : :o
  end

end
