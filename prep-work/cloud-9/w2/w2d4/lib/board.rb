class Board
  
  attr_reader :grid, :moves

  def initialize(new_grid = Array.new(3){Array.new(3)})
    @grid = new_grid
    @moves = 0
  end
  
  def grid
    @grid
  end
  
  def empty?(pos)
    return true if @grid[pos[0]][pos[1]].nil?
    false
  end
  
  def mark_at(pos)
    return @grid[pos[0]][pos[1]]
  end
  
  def place_mark(pos, mark)
    if self.empty?(pos)
     @grid[pos[0]][pos[1]] = mark
     @moves += 1
    else
     raise "position not empty"
    end
  end
  
  def winner
    if check_won(:X)
      return :X
    elsif check_won(:O)
      return :O 
    else
      return nil
    end
  end
  
  def over?
    if !self.winner.nil? or moves == 9
      return true
    else
      return false
    end
  end
  
  def check_won(mark)
    
    #horizontal & vertical
    for i in 0..2
      if (@grid[i][0] == mark) and (@grid[i][1] == mark) and (@grid[i][2] == mark)
        return true
      elsif (@grid[0][i] == mark) and (@grid[1][i] == mark) and (@grid[2][i] == mark)
        return true
      end
    end
    
    #diagonal
    if (@grid[0][0] == mark) and (@grid[1][1] == mark) and (@grid[2][2] == mark)
      return true
    elsif (@grid[0][2] == mark) and (@grid[1][1] == mark) and (@grid[2][0] == mark)
      return true
    end
    
    return false
  end
  
end
