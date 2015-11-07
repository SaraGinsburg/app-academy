require 'colorize'

class Tile
  attr_reader :value, :given
  def initialize value, given = false
    @given = false
    @value = value
  end
  def to_s
    @given ? @value.colorize(:red) : @value
  end
  def set_value val
    @value = val unless @given
  end

end

class Board

  def self.from_file file
    @grid = []
    File.readlines(file) do |line|
      values = line.split("")
      values.each do |val|
        if val == 0
          row << Tile.new(" ")
        else
          row << Tile.new(val, true)
        end
      end
      @grid << row
    end
  end

  def update_tile value, position
    row, col = position
    @grid[row][col].set_value(value)
  end

  def render
    each_with_index do |el, _, col|
      print "[#{el.to_s}]"
      puts if col == 9
    end
  end

  def solved?
    return false if any_blanks?
    return false if horizontal_errors?
    return false if vertical_errors?
    #return false if box_errors?
    true
  end

  def any_blanks?
    @grid.each_with_index do |el, _, _|
      return true if el.to_s == " "
    end
    false
  end

  def horizontal_errors?
    @grid.each do |row|
      return true if row.uniq.count < row.count
    end
    false
  end

  def vertical_errors?
    @grid[0].zip(*@grid[1..-1]).each do |col|
      return true if col.uniq.count < col.count
    end
    false
  end

  def block_errors?
    (0..9).step(3) do |row_index|
      (0..9).step(3) do |col_index|
        box = @grid.slice(row_index, 3).slice(col_index,3).flatten
        return true if box.uniq.count < box.count
      end
    end
    false
  end

  def each_with_index
    @grid.each_with_index do |_, row|
      row.each_with_index do |el, col|
        yield el, row, col
      end
    end
  end


end

class Game
end

def reload
  load __FILE__
end

Board.new(ARGV[0])
