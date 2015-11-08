
def anagram1?(str1, str2)
  str1_arr = str1.split("")
  anagrams = str1_arr.permutation(str1.length).to_a.map(&:join)
  anagrams.include?(str2)
end

def anagram2?(str1, str2)

  str1_arr, str2_arr = str1.split(''),str2.split('')
  idx1 = 0
  while idx1 < str1_arr.length #iterate through str1_arr
    idx2 = 0
    until str1_arr[idx1] == str2_arr[idx2] || idx2 == str2_arr.length #iterate through str2_arr until we find a match
      idx2 += 1
    end

    if str1_arr[idx1] == str2_arr[idx2] #deletes at indices we find a match
      str1_arr.delete_at(idx1)
      str2_arr.delete_at(idx2)
    else
      idx1 += 1
    end
  end
  str1_arr.empty? && str2_arr.empty?
end

def anagram3?(str1, str2)
  str1.split('').sort == str2.split('').sort
end

def anagram4?(str1, str2)
  counts = Hash.new(0)
  str1.each_char{ |char| counts[char] += 1 }
  str2.each_char{ |char| counts[char] -= 1 }
  counts.values.all?(&:zero?)
end

p anagram4?("gizmo", "sally")    #=> false
p anagram4?("elvis", "lives")    #=> true
