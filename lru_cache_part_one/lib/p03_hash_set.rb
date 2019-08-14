class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
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

  def include?(key)
    num = key.hash
    self[num].include?(num)
  end

  def remove(key)
    num = key.hash
    @count -= 1 if self[num].delete(num)
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
