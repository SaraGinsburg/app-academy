require 'benchmark'
def my_min_1(arr)
  arr.each_with_index  do |el, idx|
    smallest = true
    arr.each do |comp|
      if comp < el
        smallest = false
        break
      end
    end
    return el if smallest
  end
end

def my_min_2(arr)
  smallest = arr.first
  arr.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

def largest_contiguous_subsum1(arr)
  largest = 0
  size = 1
  while size < arr.length
    arr.each_cons(size).to_a.each do |sub|
      current = sub.reduce :+
      largest = current if current > largest
    end
    size += 1
  end
  largest
end

def largest_contiguous_subsum2(arr)
  current_sum = 0
  arr.each do |el|
    current_sum += el
    current_sum = 0 if current_sum < 0
  end
  current_sum
end

big_array = [*1..1_000_000].shuffle
less_big_array = [*1..10_000].shuffle
medium_array = [*1..1000].shuffle

puts Benchmark.measure {my_min_1(big_array)}
puts Benchmark.measure {my_min_2(big_array)}
puts Benchmark.measure {largest_contiguous_subsum1(medium_array)}
puts Benchmark.measure {largest_contiguous_subsum2 (medium_array)}
