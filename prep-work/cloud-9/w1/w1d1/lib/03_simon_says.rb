def echo(phrase)
  phrase
end

def shout(phrase)
  phrase.upcase
end

def repeat(phrase, count = 2)
  ((phrase+" ") * count).strip
end

def start_of_word(word, count)
  word[0..(count - 1)]
end

def first_word(phrase)
  phrase.split(" ").first
end

def titleize(phrase)
  little_words = %w{the a by on for of over are with just but and to the my in I has some}

  words = phrase.capitalize.split(' ')
  0.upto(words.length-1) {|index| words[index] =  words[index].capitalize if !little_words.include?(words[index])}
  words.join(' ')
end
