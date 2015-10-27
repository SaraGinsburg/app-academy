class Board
  
  attr_accessor :grid
  
  
  
  def initialize(new_grid = Board.default_grid)
    @grid = new_grid
  end
  
  def self.default_grid
    return Array.new(10){Array.new(10)}
  end
  
  def display
    p grid
  end
  
  def set_pos(x, y, symbol)
    @grid[x][y] = symbol
  end
  
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def empty?(pos = @grid)
    if pos == @grid
      return self.count == 0
    else
      return !(@grid[pos[0]][pos[1]] == :s)
    end
  end
  
  def full?
    @grid.each{|row| return false if row.include?(nil)}
    true
  end
  
  def place_random_ship
    if self.full?
      raise "board is full"
    else
      valid_move = false
      x = -1
      y = -1
      until valid_move
        x = rand(@grid.length)
        y = rand(@grid[0].length)
        valid_move = empty?([x, y])
      end
      @grid[x][y] = :s
    end
    
  end
  
  def won?
    return count == 0
  end
  
  def count
    count = 0
    @grid.each{|row| count += row.count(:s)}
    count
  end
  
  def populate_grid
    rand(@grid.length * @grid[0].length).times {place_random_ship}
  end
  
  def in_range(pos)
    pos[0].between?(0,(@grid.length-1)) and pos[1].between?(0,(@grid[0].length-1))
  end
end
