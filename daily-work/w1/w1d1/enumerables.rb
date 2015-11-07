class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    result=[]
    self.my_each {|el| result.push(el) if prc.call(el)}
    result
  end

  def my_reject(&prc)
    result=[]
    self.my_each {|el| result.push(el) unless prc.call(el)}
    result
  end

  def my_any(&prc)
    self.my_select(&prc).length > 0
  end

  def my_all(&prc)
    self.my_select(&prc).length == self.length
  end

  def my_flatten
    result=[]
    self.each do |el|
      if el.class == Array
        result= result + el.my_flatten
      else
        result.push(el)
      end
    end
    result
  end

  def my_zip(*arrays)
    results=[]
    self.each_with_index do |el, index|
      current_results = [el]
      arrays.my_each {|el| current_results.push(el[index])}
      results.push(current_results)
    end
    results
  end

  def my_rotate(num = 1)
    if num > 0
      num.times{self.push(self.shift) }
    else
      (-num).times{self.unshift(self.pop) }
    end
    self
  end

  def my_join(str = "")
    result = []
    new_str = ""

    self.each { |el| result.push(el).push(str) }
    result.pop
    result.each { |el| new_str << el }
    new_str
  end

  def my_reverse
    result = []
    self.each{|el| result.unshift(el)}
    result
  end


end

#arr = [1,2,3,4,5]

#My Each Test Cases
#arr.my_each {|el| puts el}

#My Select Test Cases
#p arr.my_select{|el| el.even? }
#p arr.my_select{|el| el.odd? }

#My Reject Test Cases
#p arr.my_reject{|el| el.even? }
#p arr.my_reject{|el| el.odd? }

#My Any Test Cases
#p arr.my_any{|el| el.even? }
#p arr.my_any{|el| el.odd? }
#p arr.my_any{|el| el > 10 }
#p arr.my_any{|el| el == 3}


#My All Test Cases
#p arr.my_all{|el| el.even? }
#p arr.my_all{|el| el.odd? }
#p arr.my_all{|el| el > 0 }
#p arr.my_all{|el| el < 6 }
#p arr.my_all{|el| el == 3}


#My Flatten Tests
#p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten

#My Zip Test
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
#
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# #My Rotate Test
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

#
# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
