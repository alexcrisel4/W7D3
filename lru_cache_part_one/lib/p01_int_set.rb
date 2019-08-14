
class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max,false)
  end

  def insert(num)
      validate!(num)
      @store[num] = true 
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@store.length)
  end

  def validate!(num)
    raise "Out of bounds" if !is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
     @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      if count == num_buckets - 1
        resize!
        insert(num)
      else
        @count += 1
        self[num] << num
      end
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
    
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_copy = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 0 
    store_copy.flatten.each do |ele| 
      insert(ele)
    end
  end
end
