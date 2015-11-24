class Array
  def my_inject(accumulator = nil, &block)
    i = 0

    if accumulator.nil?
      accumulator = self.first
      i += 1
    end

    while i < self.length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end

    accumulator
  end
end

def is_prime?(num)
  (2..(num/2)).none?{|div| num % div == 0}
end

def primes(count)
  primes = []
  num = 2
  until primes.length == count
    primes << num if is_prime?(num)
    num += 1
  end
  primes
end


# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  return [1] if num == 1
  facts = factorials_rec(num - 1)
  facts + [facts.last * (num-1)]
end

class Array
  def dups
    dups = Hash.new{|h,k| h[k] = []}
    self.each_with_index{|num, idx| dups[num] += [idx]}
    dups.select{|key,val| val.length > 1}
  end
end

class String
  def symmetric_substrings
    sym_subs = []
    len = self.length
    (0...len).each do |i|
      ((i+1)...len).each do |j|
        current = self[i..j]
        sym_subs << current if current == current.reverse
      end
    end
    sym_subs
  end
end

class Array
  def merge_sort(&prc)
    return self if self.length < 2

    prc ||= Proc.new{|x,y| x <=> y}

    Array.merge(self[0...(self.length/2)].merge_sort(&prc), self[(self.length/2)..-1].merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      res = prc.call(left.first, right.first)
      if res == 1
        merged << right.shift
      else
        merged << left.shift
      end
    end

    merged + left + right
  end
end
