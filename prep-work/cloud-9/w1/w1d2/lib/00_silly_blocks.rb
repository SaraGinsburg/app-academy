def reverser(&prc)
  str = prc.call
  str.split(' ').map{ |word| word.reverse }.join(' ')
end

def adder(add = 1, &prc)
  add + prc.call
end

def repeater(count = 1, &prc)
  count.times{prc.call}
end

