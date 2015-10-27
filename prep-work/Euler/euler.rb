load 'methods.rb'

count = 1
triangle = count
length = 0

while length <= 500
  count += 1
  triangle += count
  new_length = factors(triangle).count
  if new_length > length
    length = new_length
    puts "count: #{count},  triangle: #{triangle},  length: #{length}"
  end
end

puts triangle
