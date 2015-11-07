class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0.hash
    self.each_with_index do |el, i|
      sum += el.hash ^ (i+1)
    end
    sum ^ 0xffffff
  end
end

class String
  def hash
    arr = []
    self.each_byte {|char_code| arr << char_code.hash}
    arr.hash
  end
end

class Hash
  def hash
    kv_array = []
    # keys_vals_array.sort!
    each do |k,v|
      kv_array << [k.hash,v.hash]
    end
    kv_array.sort.hash
  end
end
