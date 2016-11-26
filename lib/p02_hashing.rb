class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    str = ""
    self.each do |num|
      str += num.to_s
    end
    str.to_i.hash
  end
end

class String
  def hash
    string = ""
    self.each_byte do |char|
      string += char.to_s
    end
    string.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort
    values = self.values.sort
    string = ""
    keys.map!(&:to_s)
    keys.join("").each_byte { |char| string += char.to_s }

    values.map!(&:to_s)
    values.join("").each_byte { |char| string += char.to_s }

    string.to_i.hash
  end
end
