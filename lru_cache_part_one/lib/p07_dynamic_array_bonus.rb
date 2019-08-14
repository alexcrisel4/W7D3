class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count
  
  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < capacity
      @store[i]
    else
      nil
    end
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    
  end

  def push(val)
    index = count
    resize! if count == capacity
    self[index] = val
    @count += 1
  end
 
  def unshift(val)
    resize! if count == capacity 
    copy = @store
    (0...capacity - 1).each do |i|
      @store[i+1] = copy[i]
    end
    @store[0] = val
  end

  def pop
  end

  def shift
  end

  def first
  end

  def last
  end

  def each
    i = 0
    while i < capacity 
      yield self[i] 
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    store_copy = @store 
    @store = StaticArray.new(capacity*2)
    @count = 0
    store_copy.each do |ele|
      push(ele)
    end
  end
end

#