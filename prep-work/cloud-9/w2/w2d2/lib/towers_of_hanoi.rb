# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers
  
  def initialize()
    @towers = [[3,2,1],[],[]]
  end
  
  def play
    until won?
      puts "From which stack would you like to take a disc?"
      $stdout.flush
      from = gets.chomp.to_i
      
      puts "Onto which stack would you like to place the disc?"
      $stdout.flush
      to = gets.chomp.to_i
      
      if valid_move?(from, to)
        move(from, to)
        render
      else
        puts "Invalid Move- Please try again:"
      end
    end
    puts "Congratulations, You Won!"
  end
  
  def render
    print towers
  end
  
  def move(from_tower, to_tower)
    towers[to_tower].push(towers[from_tower].pop)
  end
  
  def valid_move?(from_tower, to_tower)
    if !from_tower.between?(0,2) or !to_tower.between?(0,2)
      return false
    elsif towers[from_tower].length > 0 
      if towers[to_tower].length == 0
        return true
      elsif towers[from_tower][-1] < towers[to_tower][-1]
        return true
      end
    else
      return false
    end
  end
  
  def won?
    towers[0].length == 0 and ((towers[1].length > 0 and towers[2].length == 0) or (towers[2].length > 0 and towers[1].length == 0))
  end
end
