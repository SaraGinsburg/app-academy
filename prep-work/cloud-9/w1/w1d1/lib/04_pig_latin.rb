def translate(phrase)
  words = phrase.split(' ')
  #puts words
  for i in 0 .. (words.length-1)
    words[i] = translate_word(words[i])
  end
  words.join(' ')
end

def translate_word(word)
  until word =~ /^[aeiou].*/ or word =~ /^qu.*/
    head = word[0]
    word = word[1..-1]
    word << head
  end

  word = word[2..-1] << "qu" if word =~ /^qu.*/

  word << "ay"
end