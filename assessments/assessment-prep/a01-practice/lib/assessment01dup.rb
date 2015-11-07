class Array
  def my_inject(accumulator = nil, &block)
    itr = 0

     if accumulator.nil?
       accumulator = self.first
       itr += 1
     end

     while itr < self.length
       accumulator = block.call(accumulator, self[itr])
       itr += 1
     end

     accumulator
  end
end

def is_prime?(num)
  (2..(num/2)).none?{|div| num % div == 0 && num != div}
end

def primes(count)
  primes = []
  check_num = 2
  until primes.length == count
    primes << check_num if is_prime?(check_num)
    check_num += 1
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
  prev_fact = factorials_rec(num - 1)
  prev_fact << (prev_fact.last * (num-1))
end

class Array
  def dups
    counts = {}

    self.each_with_index do |el, idx|
      if counts.has_key?(el)
          counts[el] << idx
      else
        counts[el] = [idx]
      end
    end

    counts.select{|key,val| val.count > 1}
  end
end

class String
  def symmetric_substrings
    return [] if self.length < 2
    return [self] if self.length == 2 && self == self.reverse

    subs = []

    (1..self.length).each do |idx|
      current = self[0..idx]
      subs << current if current == current.reverse
    end

    (subs + self[1..-1].symmetric_substrings).uniq
  end
end

class Array
  def merge_sort(&prc)

    prc ||= Proc.new{|x,y| (x <=> y)}

    return [] if self.length == 0
    return self if self.length == 1
    left = self[0...(self.length/2)].merge_sort(&prc)
    right = self[(self.length/2)..-1].merge_sort(&prc)
    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      comp = prc.call(left.first, right.first)
      if comp == 1
        merged << right.shift
      else #comp == (=1 || 0)
        merged << left.shift
      end
    end
    merged + left + right

  end
end
