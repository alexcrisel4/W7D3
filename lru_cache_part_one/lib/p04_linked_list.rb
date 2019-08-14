class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
      self.prev.next = self.next
      self.next.prev = self.prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
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
    @head.next == @tail
  end

  def get(key)
    each do |node| 
      return node.val if node.key == key
    end
  end

  def include?(key)
    any?{|node| node.key == key}
  end
 
  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail 
    new_node.prev = @tail.prev
    new_node.prev.next = new_node
    @tail.prev = new_node 
  end

  def update(key, val)
    if include?(key)
      each do |node| 
        if node.key == key
          node.val = val
        end
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return true
      end
    end
    nil
  end

  def each
    current = @head.next 
    until current == @tail 
      yield current
      current = current.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
