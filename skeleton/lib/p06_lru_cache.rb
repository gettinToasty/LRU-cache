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
      link = @map.get(key)
      update_link!(link)
      return link.val
    elsif count >= @max
      eject!
      @store.append(key, calc!(key))
      @map.set(key, @store.last)
      return @store.last.val
    else
      @store.append(key, calc!(key))
      @map.set(key, @store.last)
      return @store.last.val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
