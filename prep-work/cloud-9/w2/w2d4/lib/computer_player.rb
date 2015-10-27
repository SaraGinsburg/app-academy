class ComputerPlayer
  
  attr_reader :name, :board, :mark
  
  def initialize(name)
    @name = name
    @board = nil
    @mark = nil
  end
  
  def get_move
    free_moves = []
    
    for i in 0..2
      for j in 0..2
        if self.board.empty?([i,j])
          if (@board.mark_at([(i + 1) % 3,j]) == @mark) and (@board.mark_at([(i + 2) % 3,j]) == @mark)
            return [i,j]
          elsif (@board.mark_at([i,(j + 1) % 3]) == @mark) and (@board.mark_at([i,(j + 2) % 3]) == @mark)
            return [i,j]
          elsif i == j and (@board.mark_at([(i + 1) % 3,(j + 1) % 3]) == @mark) and (@board.mark_at([(i + 2) % 3,(j + 2) % 3]) == @mark)
            return [i,j] 
          elsif i + j == 2 and (@board.mark_at([(i + 2) % 3,(j + 1) % 3]) == @mark) and (@board.mark_at([(i + 1) % 3,(j + 2) % 3]) == @mark)
            return [i,j] 
          else
            free_moves.push([i,j])
          end
        end
      end  
    end
    
    free_moves.shuffle.first
  end
  
  def display(board)
    @board = board
  end
  
  def mark=(new_mark)
    @mark = new_mark
  end
  
end
