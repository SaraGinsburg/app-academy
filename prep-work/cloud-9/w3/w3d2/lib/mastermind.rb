class Code
  attr_reader :pegs
  
  PEGS = {'r' => "Red", 'g' => "Green", 'b' => "Blue", 'y' => "Yellow", 'o' => "Orange", 'p' => "Purple"}
  
  def initialize(pegs)
    @pegs = pegs
  end
  
  def self.parse(string)
    code = string.downcase
    if code.scan(/[^rgbyop]/).count > 0 or code.length != 4
      raise "invalid colors"
    else
      Code.new(code.split(''))
    end
  end
  
  def self.random
    colors = "rgbyop"
    code = ""
    4.times {code << colors[rand(colors.length)]}
    Code.new(code.split(''))
  end
  
  def exact_matches(other_code)
    matches = 0
    (0..3).each{|i| matches += 1 if self.pegs[i] == other_code.pegs[i]}
    matches
  end
  
  def near_matches(other_code)
    matches = 0
    self.pegs.each_with_index do |color, index|
      if other_code.pegs.include?(color) and (index == 0 or !self.pegs[0..(index-1)].include?(color))
        matches += 1
      end
    end
    matches - exact_matches(other_code)
  end
    
  def [](index)
    @pegs[index]
  end
  
  def []=(index, color)
    @pegs[index] = color
  end
  
  def ==(other_code)
    if other_code.class != Code
      return false
    else
      return exact_matches(other_code) == 4
    end
  end
  
end

class Game
  attr_reader :secret_code, :guesses
  
  def initialize(code = Code.random)
    @secret_code = code
    @guesses = 12
  end
  
  def get_guess
    valid_code = nil
    while valid_code.nil?
      begin
        puts "please guess a code"
        code = gets.chomp
        valid_code = Code.parse(code)
        puts valid_code
      rescue
        puts "invalid code"
        valid_code = nil
      end
    end
    @guesses -= 1
    valid_code
  end
  
  def display_matches(code)
    puts "near matches: #{@secret_code.near_matches(code)}"
    puts "exact matches: #{@secret_code.exact_matches(code)}"
    puts "guesses remaining: #{@guesses}"
    puts ""
  end
  
  def play
    win = false
    
    puts "welcome to mastermind!"
    
    until @guesses == 0 or win
      guess = get_guess
      if @secret_code == guess
        win = true
      else 
        display_matches(guess)
      end
    end
    
    if win
      puts "corect! you win!"
    else
      puts "you lose"
    end
  end
    
end
