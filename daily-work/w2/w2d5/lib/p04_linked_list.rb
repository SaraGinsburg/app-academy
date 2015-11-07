class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prv = nil)
    @key, @val, @next, @prev = key, val, nxt, prv
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new(nil,nil,nil, @head)
    @head.next = @tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.nil?
  end

  def get(key)
    current = @head
    until current == @tail
      return current.val if current.key == key
      current = current.next
    end
    nil
  end

  def include?(key)
    current = @head
    until current == @tail
      return true if current.key == key
      current = current.next
    end
    false
  end

  def insert(key, val) #only inserts at end of list
    new_link =  Link.new(key,val, @tail, last)
    last.next = new_link
    @tail.prev = new_link
  end

  def remove(key)
    current = @head
    # prev = nil
    until current == @tail
      if current.key == key
        current.prev.next = current.next
        current.next.prev = current.prev
        # prev.next = current.next
        return current
      end
      # prev = current
      current = current.next
    end
    nil
  end

  def each(&blk)
    current = first
    until current == @tail
      blk.call(current)
      current = current.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
