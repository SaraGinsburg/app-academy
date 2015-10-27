def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(arr)
  total = 0
  arr.each{|item| total = total + item}
  total
end

def multiply(*multiples)
  total = 1
  multiples.each{|item| total = total * item}
  total
end

def power(a, b)
  total = 1
  b.abs.times{total = total * a}
  b < 0 ? 1.0 / total : total
end

def factorial(n)
  total = 1
  n.downto(1) {|x| total = total * x}
  total
end
    