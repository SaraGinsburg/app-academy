class Hangman
  attr_reader :guesser, :referee, :board
  
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = []
  end
  
  def setup
    length = referee.pick_secret_word
    guesser.register_secret_length(length)
    length.times{@board.push(nil)}
    print_board
  end
  
  def take_turn
    guess = guesser.guess
    indices = referee.check_guess(guess)
    update_board(guess, indices)
    guesser.handle_response
  end
  
  def update_board(guess, indices)
    indices.each{|i| @board[i] = guess}
  end
  
  def print_board
    status = ""
    @board.each do |letter|
      if letter.nil?
        status << "_"
      else
        status << letter
      end
    end
    puts ""
    puts status
  end
  
  def play
    self.setup
    until !@board.include?(nil)
      guess = guesser.guess(@board)
      indicies = referee.check_guess(guess)
      update_board(guess, indicies)
      print_board
      guesser.handle_response(guess, indicies)
    end
    puts "game over"  
  end
    
  
end

class HumanPlayer
  attr_reader :secret_length
  
  def initialize()
    @secret_length = nil
  end
  
  def pick_secret_word
    puts "how long is your word?"
    return gets.chomp.to_i
  end
  
  def register_secret_length(length)
    @secret_length = length
  end
  
  def check_guess(guess)
    indicies = []
    puts "does the word have a(n) #{guess}?"
    choice = gets.chomp.downcase
    if  choice == ("yes" or "y")
      puts "please list the indicies of the letter, separated by a comma (but no spaces)"
      indicies = gets.chomp.split(",").map{|index| index.to_i}
    end
    indicies
  end 
  
  def guess(board)
    puts "please guess a letter"
    guess = gets.chomp
    guess[0]
  end
  
  def handle_response(guess, indicies)
    if indicies.length == 1
      puts "good guess! there was 1 #{guess}"
    elsif indicies.length > 1
      puts "good guess! there were #{indicies.length} #{guess}'s"
    else
      puts "there were 0 #{guess}'s"
    end
    puts "\n\n"
  end

  
end

class ComputerPlayer
  
  attr_reader :dictionary, :candidate_words, :secret_word, :secret_length, :bad_letters
  
  def initialize(dictionary = [])
    @dictionary = dictionary
    @secret_word = nil
    pick_secret_word
    @secret_length = nil
    @candidate_words = dictionary
    @bad_letters = []
  end
  
  def pick_secret_word
    if dictionary.length > 0
      @secret_word = @dictionary[rand(dictionary.length)].chomp
      return @secret_word.length
    else
      @secret_word = ""
      return 0
    end
  end
  
  def register_secret_length(length)
    @secret_length = length
    @secret_word = Array.new(length)
  end
  
  def check_guess(guess)
    indices = []
    @secret_word.split("").each_with_index{ |letter, index| indices.push(index) if letter == guess}
    indices
  end 
  
  def guess(board)
    letters_string = @candidate_words.join("")
    max = 0
    guess = nil
    
    for char_ord in ("a".ord.."z".ord)
      letter = char_ord.chr
      char_count = letters_string.count(letter)
      if char_count > max and !board.include?(letter) and !bad_letters.include?(letter)
        max = char_count
        guess = letter
      end 
    end

    guess
  end
  
  def handle_response(letter, array)
    array.each{|index| @secret_word[index] = letter}
    bad_letters.push(letter) if array.length == 0
    update_candidate_words
  end
  
  def update_candidate_words
    words = []
    @dictionary.each do |word|

      if word.length == @secret_length
        all_matches = true
        @secret_word.each_with_index do |letter, index|
          
          #possible conditions
          exact_match = (word[index] == letter)
          spot_nil = letter.nil?
          if index > 0
            other_instance = @secret_word[0..(index - 1)].include?(word[index])
          else
            other_instance = false
          end
          been_guessed = bad_letters.include?(word[index])
            
          if been_guessed or (!exact_match and (!spot_nil or other_instance))
            all_matches = false
          end 

        end
        words.push(word) if all_matches
      end
    end 
    @candidate_words = words
  end

  def candidate_words
    update_candidate_words
    @candidate_words
  end
  
end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("lib/dictionary.txt")
  dictionary.map!{|entry| entry.chomp}
  
  puts "Welcome to Hangman!"
  puts "Would you like to have a human guesser?"
  guesser_choice = gets.chomp.downcase
  if guesser_choice == "yes"
    guesser = HumanPlayer.new
  else
    guesser = ComputerPlayer.new(dictionary)
  end

  puts "Would you like to have a human referee?"
  referee_choice = gets.chomp.downcase
    if referee_choice == "yes"
    referee = HumanPlayer.new
  else
    referee = ComputerPlayer.new(dictionary)
  end
  
  Hangman.new({referee: referee, guesser: guesser}).play

end