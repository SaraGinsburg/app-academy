load 'methods.rb'

puts "start"
num = 600851475143
i = Math.sqrt(num).to_i + 1

while i > 0
 puts "-#{i} " if i % 10000000 == 0
 if num % i == 0 && prime?(i)
  puts i
 end
 i = i - 2
end

puts "end"
