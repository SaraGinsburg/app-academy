class Array
  # Write a method that binary searches an array for a target and returns its
  # index if found. Assume a sorted array
  def binary_search(target)
    return 0 if self.length == 1 && self.first == target
    return nil if self.empty? || self.length == 1

    mid = (self.length / 2)

    if self[mid] == target
      mid
    elsif self[mid] > target
      self[0...mid].binary_search(target)
    else
      right_res = self[mid..-1].binary_search(target)
      return (mid) + right_res unless right_res.nil?
      nil
    end
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    pairs = []

    self.each_with_index do |el_1, idx_1|
      idx_2 = idx_1 + 1

      while idx_2 < self.length
        pairs << [idx_1, idx_2] if (el_1 + self[idx_2] == target)
        idx_2 += 1
      end

    end

    pairs
  end
end

# write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return 0 if nums.empty?
  nums.first + sum_rec(nums[1..-1])
end

class String
  # Write a `String#symmetric_substrings` method that takes a returns
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  def symmetric_substrings
    sym_subs = []
    (0...self.length).each do |first_letter|
      ((first_letter + 1)...self.length).each do |last_letter|
        current_word = self[first_letter..last_letter]
        sym_subs << current_word if current_word == current_word.reverse
      end
    end
    sym_subs
  end
end

def is_prime?(num)
  (2...num).none?{|div| num % div == 0}
end

# Write a method that returns the nth prime number
def nth_prime(n)
  return nil if n < 1

  primes = 0
  check_num = 1

  until primes == n
    check_num += 1
    primes += 1 if is_prime?(check_num)
  end

  check_num
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    idx = 0

    while idx < self.length
      prc.call(self[idx])
      idx += 1
    end

    self
  end
end
