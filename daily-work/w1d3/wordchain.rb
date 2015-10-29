require 'set'
require 'byebug'

class WordChainer

  attr_reader :dictionary

  def initialize(dictionary_file_name)
    @dictionary = IO.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty?
      @new_current_words = []
      @current_words.each do |current_word|
        explore_current_words(current_word)
      end
      break if @all_seen_words.has_key?(target)
      # p @new_current_words
      #debugger
      @current_words = @new_current_words
    end
    build_path(target)
  end

  def build_path(target)
    result = [target]
    current = target
    until current.nil?
      new_target = @all_seen_words[current]
      result.unshift(new_target)
      current = new_target
    end
    result.shift
    result
  end

  def explore_current_words(current_word)
    adjacent_words(current_word).each do |adjacent_word|
      next if @all_seen_words.has_key?(adjacent_word)

      @all_seen_words[adjacent_word] = current_word
      @new_current_words << adjacent_word
    end
    # @all_seen_words.each{|adj, curr| puts "#{adj} => #{curr}"}
  end

  # def explore_current_words(current_word)
  #   result = []
  #   adjacent_words(current_word).each do |adjacent_word|
  #     next if @all_seen_words.include?(adjacent_word)
  #     @all_seen_words << adjacent_word
  #     result << adjacent_word
  #   end
  #   result
  # end



  def adjacent_words(word)
    common_length = same_length(word.length)
    one_letter_difference(word, common_length)
  end

  def same_length(length)
    @dictionary.select{ |word| word.length == length}
  end

  def one_letter_difference(target, dict)
    target_arr = target.split("")
    dict.select do |word|
      misses = 0
      word.split("").each_with_index do |char, idx|
        misses += 1 if char != target_arr[idx]
      end
      misses == 1
    end
  end


end






#TEST
wc = WordChainer.new('./dictionary.txt')
#puts wc.dictionary[0]




def reload
  load 'wordchain.rb'
end
