class Card
  attr_accessor :face_value, :face_up, :values_dict

  @@values_dict = ("A".."Z").to_a

  def self.random_card
    Card.new(@@values_dict.shift)
  end

  def initialize(value)
    @face_value = value
    @face_up = false
  end

  def display
    if @face_up
      @face_value
    else
      "-"
    end
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    @face_value.to_s
  end

  def ==(other_card)
    @face_value == other_card.face_value
  end

  def dup
    Card.new(face_value)
  end


end

class Board
  attr_accessor :grid

  def initialize dimension
    @grid = populate (dimension)
  end

  def generate_cards dim
    cards_needed = dim ** 2
    pairs = cards_needed / 2

    cards = []
    pairs.times do
      card1 = Card.random_card
      card2 = card1.dup
      cards << card1 << card2
    end
    cards
  end

  def populate (dim)
    new_grid = Array.new(dim) {Array.new(dim)}

    cards = generate_cards (dim)
    cards.shuffle!


    new_grid.map do |row|
      row.map do |slot|
        slot = cards.pop
      end
    end
  end

  def render
    grid.each do |row|
      row.each do |slot|
        print slot.display
      end
      puts
    end
  end

  def won?
    grid.each do |row|
      row.each do |slot|
        return false if !slot.face_up
      end
    end
    true
  end

  def reveal(row, col)
    grid[row][col].reveal
    grid[row][col].face_value
  end

  def each
    @grid.each do |row|
      row.each do |slot|
        yield slot
      end
    end
  end
end

class Game
  attr_accessor :board, :players

  def initialize *players
    @players = players
    @board = Board.new(4)
  end

  def current_player
    @players.first
  end

  def next_player!
    @players.rotate!
  end

  def play
    #start prompt

    until over
      system("clear")
      puts "#{current_player.name}'s Turn: "
      make_guess
      next_player!
    end

    puts "#{winning.name} won!"

  end

  def winning
    players_by_points = @players.sort_by{|player| -player.points}
    players_by_points.first
  end

  def render
    @board.render
  end

  def prompt
    row, col = nil, nil
    loop do
      row, col = current_player.get_prompt @board
      break if valid_guess row, col
      puts "invalid guess"
    end

    @board.grid[row][col]
  end

  def valid_guess row, col
    return false unless (0...@board.grid.length).include?(row)
    return false unless (0...@board.grid.length).include?(col)
    return false if @board.grid[row][col].face_up
    true
  end


  def over
    @board.won?
  end


  def make_guess
    current_player.look @board
    guess1 = prompt
    guess1.reveal

    current_player.look @board
    guess2 = prompt
    guess2.reveal


    #match
    unless guess1 == guess2
      current_player.look @board
      puts "#{current_player.name} missed (press enter to continue)"
      guess1.hide
      guess2.hide
      gets

    else
      current_player.add_match
    end
    system("clear")
  end

end

class Player
  attr_accessor :name, :points
  def initialize name
    @name = name
    @points = 0
  end

  def look board
    board.render
  end

  def get_prompt board
    print "enter guess (row, col): "
    row, col = gets.chomp.split(",").map(&:strip).map(&:to_i)
  end

  def add_match
    @points += 1
  end
end


##THIS DOES NOT WORK

# class ComputerPlayer < Player
#   @locations = []
#   @guess = []
#   @next_guess = []
#
#   def get_prompt board
#     if @next_guess == []
#       @guess = check_for_match
#       @guess
#     else
#       final_guess = @next_guess
#       @next_guess = []
#       final_guess
#     end
#   end
#
#   def check_for_match
#     @locations.each_with_index do |target, idx|
#       @locations[(idx+1)..-1].each_with_index do |check, idx2|
#         card1 = target[0]
#         pos1 = target[1]
#         card2 = check[0]
#         pos2 = check[1]
#
#         if card1.face_value == card2.face_value
#
#           if pos1 == @guess
#             @next_guess = pos2
#           elsif pos2 == @guess
#             @next_guess = pos1
#           else
#
#           end
#           return @next_guess
#         end
#       end
#     end
#     return random_guess
#   end
#
#   def random_guess
#     possible_guesses = []
#     grid = @board.grid
#     grid.each_with_index do |_, row|
#       row.each_with_index do |card, col|
#         possible_guesses << [row, col] unless card.face_up
#       end
#     end
#     possible_guesses.shuffle.first
#   end
#
#
#   def look board
#     @board = board
#     @board.grid.each_with_index do |_, row|
#       row.each_with_index do |card, col|
#         @locations << [card.face_value, [row, col]]
#       end
#     end
#     @locations.uniq!
#   end
#
# end
#
# def reload
#   load 'MemoryPuzzle.rb'
# end
