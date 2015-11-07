require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_board = TicTacToeNode.new(game.board.dup, mark)
    winning_move(current_board, mark) || not_losing_move(current_board, mark)
  end

  def winning_move(board, mark)
    board.children.each do |child|
      return child.prev_move_pos if child.winning_move?(mark)
    end
    nil

    # puts "checking for win"
    # potential_wins = []
    # board.board.rows.each{ |row| p row }
    # board.children.each do |child|
    #
    #   puts
    #   child.board.rows.each{ |row| p row}
    #
    #   potential_wins << child if child.winning_node?(mark)
    # end
    #
    # potential_wins.each do |move|
    #   return move.prev_move_pos if board.children.include?(move)
    #
    #   board.children.each do |second_move|
    #     return move.prev_move_pos if second_move.children.include?(move)
    #   end
    # end
    # return potential_wins.first.prev_move_pos unless potential_wins.empty?
    # nil
  end

  def not_losing_move(board, mark)
    p "no_win"
    board.children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end
    raise "Impossible!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
