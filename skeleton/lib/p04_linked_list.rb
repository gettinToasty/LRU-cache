class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
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
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    last.next = new_link
    new_link.prev = last
    @tail.prev = new_link
    new_link.next = @tail
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
  end

  def remove(key)
    each do |link|
      if link.key == key
        prev_link = link.prev
        next_link = link.next
        prev_link.next = next_link
        next_link.prev = prev_link
      end
    end
  end

  def each(&prc)
    return if empty?
    cur_link = first
    until cur_link == @tail
      prc.call(cur_link)
      cur_link = cur_link.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
