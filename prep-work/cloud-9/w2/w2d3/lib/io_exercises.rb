# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  target = 1 + rand(100)
  guess = 0
  guesses = 0
  
  while !(guess == target)
    puts "guess a number"
    guess = gets.chomp.to_i
    if guess > target
      puts "#{guess}: too high"
    elsif guess < target
      puts "#{guess}: too low"
    end
    guesses += 1
  end
  
  puts "Congratulations, it took you #{guesses} guesses to figure out that the number was #{target}!"
end

def file_shuffler
  puts "what file would you like to shuffle?"
  file_name = gets.chomp
  p file_name
  contents = File.readlines(file_name)
  contents.shuffle!
  
  File.open("#{file_name[0..-5]}-shuffled.txt", "w") do |f|
    contents.each { |line| f.puts line}
  end
end
  