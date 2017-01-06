class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    unique_val = 0

    each_with_index do |el, i|
      el.is_a?(Fixnum) ? unique_val += (el + 5) * (i + 1) : unique_val += el.hash
    end

    unique_val.hash
  end
end


class String
  def hash
    unique_val = 0

    chars.each_with_index do |el, i|
      unique_val += (el.ord + 5) * (i + 1)
    end

    unique_val.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    unique_val = 0
    each do |key, val|
      unique_val += key.hash
      unique_val += val.hash
    end

    unique_val.hash
  end
end
