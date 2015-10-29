def reload
  load 'recursion.rb'
end

def range(start_val, end_val)
  #base case
  return [] if end_val < start_val

  #divide
  arr = [start_val]

  #combine
  arr + range(start_val + 1, end_val)
end

def sum_recursive(arr)
  return arr.first if arr.length == 1
  sum = arr.shift
  sum + sum_recursive(arr)
end

def sum_iterative(arr)
  sum = 0
  arr.each do |el|
    sum += el
  end
  sum
end

def exp_1(base, n)
  return 1 if n == 0
  # return base if n == 1
  base * exp_1(base, n- 1)
end

def exp_2(base, n)
  return 1 if n == 0
  return base if n == 1
  return exp_2(base, n/2) ** 2 if n.even?
  base * exp_2(base, (n - 1)/2) ** 2
end

def deep_dup(arr)
  arr.inject([]) do |result, el|
    if el.is_a?(Array)
      result << deep_dup(el)
    else
      result << el
    end
    result
  end
end


def fib(num)
  return [1] if num == 1
  return [1,1] if num == 2

  arr = fib(num - 1)
  next_fib = arr[-1] + arr[-2]
  arr << next_fib
  arr

end

def bsearch(array, num)
  length = array.length
  mid = length / 2

  return 0 if length == 1 && array[0] == num
  return nil if length == 1

  if num < array[mid]
    bsearch(array[0...mid], num)
  else
    right = bsearch(array[mid..-1 ], num)
    return right + mid if right
  end
  nil
end

def make_change(amount, coins = [25,10,5,1])
  #base case
  return [] if amount == 0
  return [] if coins.length == 0

  #current coinage
  max_coin = 0
  coins.each do |coin|
    if coin <= amount
      max_coin = coin
      break
    end
  end

  current = [max_coin] + make_change((amount - max_coin), coins)

  #alt coinage
  alt = make_change(amount, coins[1..-1])

  return current if alt.length == 0
  return alt if current.length == 0
  current.length < alt.length ? current : alt
end

def merge_sort(arr)
  #base
  return [] if arr.length == 0
  return arr if arr.length == 1

  #divide
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])

  #combine
  merge(left,right)
end

def merge(left, right)
  result = []

  until left.empty? || right.empty?
    if left.first < right.first
      result << left.shift
    else
      result << right.shift
    end
  end

  result + left + right
end

def subsets(arr)
  #base case
  return [arr] if arr.empty?
  return [[],arr] if arr.length == 1

  #recursive
  head_el = arr.shift
  subset_no_head = subsets(arr)
  subset_with_head = []
  subset_no_head.each do |set|
    subset_with_head << set.dup.unshift(head_el) #sorted to look nice!
  end

  puts "no head: #{subset_no_head}"
  puts "with head: #{subset_with_head}"

  (subset_no_head + subset_with_head) #sorted to look nice!
end


#def recursive problem
  #base case
  #divide
  #combine
#end
