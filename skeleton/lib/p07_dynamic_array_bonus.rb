class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > @count
    i >= 0 ? i : i += @count
    return nil if i < 0
    @store[i]
  end

  def []=(i, val)
    return nil if i > @count
    i >= 0 ? i : i += @count
    return nil if i < 0
    until @count >= i
      push(nil)
    end
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each { |el| return true if el == val }
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    @count += 1
    resize! if @count == capacity
    idx = @count-1
    until idx < 0
      @store[idx+1] = @store[idx]
      idx -= 1
    end
    @store[0] = val
  end

  def pop
    return nil if @count == 0
    val = last
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count <= 0
    val = first
    idx = 0
    until idx == @count
      @store[idx] = @store[idx + 1]
      idx += 1
    end
    @count -= 1
    val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    return if @count == 0
    idx = 0
    until idx == @count
      prc.call(self[idx])
      idx += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    idx = 0
    until idx == @count
      return false unless self[idx] == other[idx]
      idx += 1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    elements = @store
    @store = StaticArray.new(capacity * 2)
    idx = 0
    until idx == elements.length
      @store[idx] = elements[idx]
      idx +=1
    end

  end
end
