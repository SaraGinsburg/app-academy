class MyStack

  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(obj)
    @store.push(obj)
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end


class MinMaxStack
  def initialize
    @store = MyStack.new
    @max_tracker = MyStack.new
    @min_tracker = MyStack.new
  end

  def min
    @min_tracker.peek
  end

  def max
    @max_tracker.peek
  end

  def push(num)
    @store.push(num)
    if @store.size == 1
      @max_tracker.push(num)
      @min_tracker.push(num)
    else
      if @max_tracker.peek >= num
        @max_tracker.push(@max_tracker.peek)
      else
        @max_tracker.push(num)
      end

      if @min_tracker.peek <= num
        @min_tracker.push(@min_tracker.peek)
      else
        @min_tracker.push(num)
      end
    end
  end

  def pop
    @max_tracker.pop
    @min_tracker.pop
    @store.pop
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

end


class MinMaxStackQueue
  def initialize
    @in_stack = MinMaxStack.new
    @out_stack = MinMaxStack.new
  end

  def min
    if @in_stack.empty?
      return @out_stack.min
    elsif @out_stack.empty?
      return @in_stack.min
    else
      [@in_stack.min, @out_stack.min].min
    end
  end

  def max
    if @in_stack.empty?
      return @out_stack.max
    elsif @out_stack.empty?
      return @in_stack.max
    else
      [@in_stack.max, @out_stack.max].max
    end
  end

  def enqueue(obj)
    @in_stack.push(obj)
  end

  def dequeue
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end

    @out_stack.pop
  end


  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
end
