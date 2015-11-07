require_relative "board.rb"
require 'yaml'

def reload
  load 'game.rb'
  load 'board.rb'
  load 'tile.rb'
end

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def play
    welcome_user
    until won? || lost?
      board.render
      user_move = prompt_input
      if user_move == :quit
        save_game
        break
      end
      process_move(user_move)
    end

    board.render
    if won?
      puts "You win"
    elsif lost?
      puts "You lose!"
      reveal_entire_board
    else
      puts "Goodbye"
    end
  end

  def reveal_entire_board
    board.grid.flatten.each { |tile| tile.reveal }
    board.render
  end

  def prompt_input
    puts "What would you like to do?"
    puts "-Enter \"r\" to reveal a tile"
    puts "-Enter \"f\" to flag a tile"
    puts "-Enter \"quit\" to save and quit the game"

    choice = gets.strip.downcase

    return :quit if choice == "quit"

    puts "Where would you like to do so? (x,y)"
    position = gets.strip.split(",")

    {move_type: choice, x: position[0].to_i, y: position[1].to_i}
  end

  def get_tile(x,y)
    @board.grid[x][y]
  end

  def process_move(user_move)
    if user_move[:move_type] == "f"
      get_tile(user_move[:x], user_move[:y]).toggle_flag
    elsif user_move[:move_type] == "r"
      guessed_tile = get_tile(user_move[:x], user_move[:y])
      guessed_tile.reveal
      unless guessed_tile.is_bomb? || guessed_tile.value > 0
        reveal_neighbors(user_move[:x], user_move[:y])
      end
    else
      puts "c'mon dude"
    end
  end

  def reveal_neighbors(x, y)
    queue = board.neighbors([x,y])
    until queue.empty?
      neighbor = queue.shift
      unless neighbor[:tile].is_bomb? || neighbor[:tile].revealed
        neighbor[:tile].reveal
        if neighbor[:tile].value == 0
          queue += board.neighbors([neighbor[:x], neighbor[:y]])
        end
      end
    end
  end


  def welcome_user
    puts "Welcome to Minesweeper"
    puts "Would you like to load a saved game? (y/n)"
    load_game if gets.chomp.downcase == "y"
  end

  def won?
    all_tiles = board.grid.flatten
    safe_tiles = all_tiles.count - board.bomb_count

    safe_tiles == all_tiles.count { |tile| tile.revealed }
  end

  def lost?
    all_tiles = board.grid.flatten
    all_tiles.any?{|tile| tile.is_bomb? && tile.revealed}
  end

  def save_game
    save = @board.to_yaml
    File.open("save.txt", "w") do |f|
      f.puts save
    end
  end

  def load_game
    loaded_board = File.read("save.txt")
    @board = YAML::load(loaded_board)
  end


end
