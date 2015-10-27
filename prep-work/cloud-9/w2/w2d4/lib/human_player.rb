class HumanPlayer
  
  attr_reader :name, :mark
  
  def initialize(name)
    @name = name
    @mark = nil
  end
  
  def get_move
    puts "Where would you like to place your mark?"
    puts "Please enter a position of the form '0, 0'"
    entry = gets.chomp
    [entry[0].to_i,entry[-1].to_i]
  end
  
  def display(board)
    p board
  end
end
