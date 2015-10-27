class HumanPlayer
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def get_play
    guess = nil
    while guess.nil?
      puts "please guess a location in 'x, y' form"
      guess = gets.chomp
    end
    
    return [guess[0].to_i, guess[-1].to_i]
  end
    
end
