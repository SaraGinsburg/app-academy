require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      # update_link!(@map.get(key))
      link = @map[key]
      update_link!(link)
      link.val
    else
      # new_val = calc!(key)
      # @store.insert(key, new_val)
      # @map.set(key, @store.last)
      # eject! if count > @max
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_link = @store.insert(key, val)
    @map[key] = new_link

    eject! if count > @max
    val
    # p key
    # p "call! "
    # p @prc.call(key)
  end

  def update_link!(link)
    moving_link = @store.remove(link.key)
    @store.insert(moving_link.key, moving_link.val)
    @map.set(moving_link.key, @store.last)
  end

  def eject!
    removed = @store.remove(@store.first.key)
    @map.delete(removed.key)
  end
end
