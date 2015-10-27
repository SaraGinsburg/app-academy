#####QUICK SORT#####

	
def quick_sort(array)
	quick_sort_helper(array, 0, array.length - 1)
end

def quick_sort_helper(array, low, hi)
	if low < hi
		p = partition(array, low, hi)
		quick_sort_helper(array, low, p-1)
		quick_sort_helper(array, p+1, hi)
	end
end

def partition(array, low, hi)
	pivot = array[hi]
	i = low
	for j in low..hi-1
		if array[j] <= pivot
			array[i], array[j] = array[j], array[i]
			i += 1
		end	
	end
	array[i], array[hi] = array[hi], array[i]
	return i	
end


#####MERGE SORT#####	
	
	
def merge_sort(array)
	array = merge_sort_helper(array)
end

def merge_sort_helper(array)
	n = array.length
	if array.length < 2
		return array
	else
		left = merge_sort_helper(array[0..n/2-1])
		right = merge_sort_helper(array[n/2..-1])
		return combine(left,right)
	end
end

def combine(arr1, arr2)
	comb = []
	until arr1.length < 1 or arr2.length < 1
		if arr1.first <= arr2.first
			comb.push(arr1.shift)
		else
			comb.push(arr2.shift)
		end
	end
	if arr1.length < 1
		comb = comb + arr2
	else
		comb = comb + arr1
	end
	return comb
end

