class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    h = 0
    self.each_with_index do |ele, i|
      h += (ele + i).hash 
    end
    h
  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    h = 0
    self.each_char.with_index do |char, i|
      h += (alpha.index(char.downcase) + i).hash
    end
    h
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = 0
    self.each do |k,v|
      h += (k.hash + v.hash)
    end
    h
  end
end
