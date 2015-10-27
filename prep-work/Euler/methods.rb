def prime?(num)
  (2...Math.sqrt(num)).each do |idx|
    if num % idx == 0
      return false
    end
  end
  true
end

def factors(i)
  factors = [i]
  (1..(i/2)).each{|fac| factors.push(fac) if i % fac == 0}
  factors
end

def palindrome?(i)
  i.to_s.reverse == i.to_s
end
