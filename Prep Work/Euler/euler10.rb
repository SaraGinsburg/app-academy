require 'byebug'
load 'methods.rb'

sum = 2

i = 3
while i < 2000000
 if prime?(i)
  sum += i
  puts i
  puts "sum = #{sum}"
 end
 i += 1
end

puts sum
