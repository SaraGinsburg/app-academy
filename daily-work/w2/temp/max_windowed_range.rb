require_relative 'min_max_stack'

def max_windowed_range_naive(arr, w)
  windows = arr.each_cons(w).to_a
  max_range = 0
  windows.each do |window|
    window_range = window.max - window.min
    if  window_range > max_range
      max_range = window_range
    end
  end
  max_range
end



def stack_queue_windowed_range(array, w)
  arr = array.dup
  stack_queue = MinMaxStackQueue.new
  w.times do
    stack_queue.enqueue(arr.shift)
  end

  max_range = stack_queue.max - stack_queue.min

  until arr.empty?
    stack_queue.enqueue(arr.shift)
    stack_queue.dequeue
    range = stack_queue.max - stack_queue.min
    max_range = range if range > max_range
  end
  max_range
end



p stack_queue_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p stack_queue_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p stack_queue_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p stack_queue_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
