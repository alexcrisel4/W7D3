require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
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
    if !@map.include?(key)
      eject! if count == @max
      calc!(key)
    else
      update_node!(key)
    end
    @map[key].val
   
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    @map[key] = @store.append(key, @prc.call(key))
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(key)
      node = @map[key]
      node.remove
      @map[key] = @store.append(key, node.val) 
    # suggested helper method; move a node to the end of the list
  end

  def eject!
      node = @store.first 
      @store.remove(node.key)
      @map.delete(node.key)
  end
end
