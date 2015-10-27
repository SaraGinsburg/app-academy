#load script
#require_relative 'sorts'
load 'sorts.rb'

array_10 = []
array_100 = []
array_1000 = []
array_10000 = []
array_100000 = []
array_1000000 = []

10.times{ array_10.push(rand())}
100.times{ array_100.push(rand())}
1000.times{ array_1000.push(rand())}
10000.times{ array_10000.push(rand())}
100000.times{ array_100000.push(rand())}
1000000.times{ array_1000000.push(rand())}

#p array_10
#p array_100
#p array_1000
#p array_10000
##p array_100000 -never uncomment me
##p array_1000000 -never uncomment me



## 10 Items

qs_10 = Time.now
quick_sort(array_10)
qs_10_t = Time.now - qs_10

array_10.shuffle!

ms_10 = Time.now
merge_sort(array_10)
ms_10_t = Time.now - qs_10

puts "10 items"
puts "Merge Sort: #{ms_10_t}"
puts "Quick Sort: #{qs_10_t}"


## 100 Items

qs_100 = Time.now
quick_sort(array_100)
qs_100_t = Time.now - qs_100 

array_100.shuffle!

ms_100 = Time.now
merge_sort(array_100)
ms_100_t = Time.now - qs_100

puts "100 items"
puts "Merge Sort: #{ms_100_t}"
puts "Quick Sort: #{qs_100_t}"


## 1000 Items

qs_1000 = Time.now
quick_sort(array_1000)
qs_1000_t = Time.now - qs_1000 

array_1000.shuffle!

ms_1000 = Time.now
merge_sort(array_1000)
ms_1000_t = Time.now - qs_1000

puts "1000 items"
puts "Merge Sort: #{ms_1000_t}"
puts "Quick Sort: #{qs_1000_t}"


## 10000 Items

qs_10000 = Time.now
quick_sort(array_10000)
qs_10000_t = Time.now - qs_10000 

array_10000.shuffle!

ms_10000 = Time.now
merge_sort(array_10000)
ms_10000_t = Time.now - qs_10000

puts "10000 items"
puts "Merge Sort: #{ms_10000_t}"
puts "Quick Sort: #{qs_10000_t}"


## 100000 Items

qs_100000 = Time.now
quick_sort(array_100000)
qs_100000_t = Time.now - qs_100000 

array_100000.shuffle!

ms_100000 = Time.now
merge_sort(array_100000)
ms_100000_t = Time.now - qs_100000

puts "100000 items"
puts "Merge Sort: #{ms_100000_t}"
puts "Quick Sort: #{qs_100000_t}"


## 1000000 Items

qs_1000000 = Time.now
quick_sort(array_1000000)
qs_1000000_t = Time.now - qs_1000000 

array_1000000.shuffle!

ms_1000000 = Time.now
merge_sort(array_1000000)
ms_1000000_t = Time.now - qs_1000000

puts "1000000 items"
puts "Merge Sort: #{ms_1000000_t}"
puts "Quick Sort: #{qs_1000000_t}"



