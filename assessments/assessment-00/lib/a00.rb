# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  chrs = ("a".."z").to_a

  str_array = str.downcase.split("")
  result = ""
  str_array.each do |letter|
    if letter != " "
      result << chrs[(chrs.find_index(letter) + shift) % 26]
    else
      result << " "
    end
  end
  result
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  while num > 10
    digit = num % 10
    num = (num - digit) / 10 + digit
  end
  num
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

def jumble_sort(str, alphabet = nil)
  alphabet = ("a".."z").to_a if alphabet.nil?

  index_arr = []
  final_str = ""

  str.split("").each{ |letter| index_arr.push(alphabet.find_index(letter))}
  index_arr.sort!
  index_arr.each{|index| final_str << alphabet[index]}
  final_str
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    coordinates = []
    i = 0
    while i < self.length
      j = i + 1
      while j < self.length
         coordinates.push([i,j]) if self[i] + self[j] == 0
         j += 1
      end
      i += 1
    end
    coordinates
  end

end

# Determine if a string is symmetrical. 'racecar' and 'too hot to hoot' are
# examples of symmetrical strings.
#
# Do NOT use any built-in `reverse` methods.

class String
  def symmetrical?
    str = self.split(" ").join("")
    i = 0
    while i < str.length
      return false if str[i] != str[-(i+1)]
      i += 1
    end
    true
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  for i in (1..num)
    factors.push(i) if num % i == 0
  end
  factors
end
