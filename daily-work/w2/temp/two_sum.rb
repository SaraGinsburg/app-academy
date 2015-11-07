def bad_two_sum?(arr, target)
  arr.each_with_index do |_, idx1|
    idx2 = idx1 + 1
    while idx2 < arr.length
      return true if arr[idx1] + arr[idx2] == target
      idx2 += 1
    end
  end
  false
end

def okay_two_sum?(arr, target)
  arr.sort!
  big_idx = 1
  small_idx = 0

  while big_idx < arr.length && small_idx >= 0
    sum = arr[big_idx] +  arr[small_idx]
    if sum < target
      big_idx += 1
      small_idx += 1
    elsif sum > target
      small_idx -= 1
    else
      return true
    end
  end
  false
end

def two_sum?(arr, target)
  pairs = {}
  arr.each do |num|
    pairs[num] = target - num unless num == target - num
  end

  return true if arr.count(target / 2) > 1

  pairs.values.any? {|value| pairs.has_key?(value)}
end

arr = [0, 1, 5, 5, 7]
# p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10) # => should be false

def three_sum?(arr, target)
  pairs = {}
  arr.each do |num|
    pairs[num] = target - num #unless num == target - num
  end

  pairs.each do |key, value|
    exclusive_arr = arr.dup
    exclusive_arr.delete(key)
    if two_sum?(exclusive_arr, value)
      return true
    end
  end
  false
end


def n_sum? (n, arr, target)
  pairs = {}
  arr.each do |num|
    pairs[num] = target - num unless num == target - num && n == 2
  end

  return true if arr.count(target / n) >= n

  if n > 2
    pairs.each do |key, value|
      exclusive_arr = arr.dup
      exclusive_arr.delete(key) 
      #p [key, n, arr, target]

      if n_sum?(n - 1, exclusive_arr, value)
        return true
      end
    end
    false
  else #n == 2 condition
    pairs.values.any? {|value| pairs.has_key?(value)}
  end
end
ar = [2,5,8,3,7,4]
p n_sum?(4, ar, 22) # => should be true
#p three_sum?(arr, 13) # => should be false
