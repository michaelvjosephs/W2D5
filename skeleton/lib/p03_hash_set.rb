require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash

    return if include?(key)

    resize! if count == num_buckets

    self[num] << num
    @count += 1
  end

  def include?(key)
    num = key.hash
    self[num].include?(num)
  end

  def remove(key)
    num = key.hash
    self[num].delete(num)
  end

  private
  attr_accessor :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    helper = store
    new_count = count * 2
    @store = Array.new(new_count) { Array.new }
    @count = 0

    helper.each do |bucket|
      bucket.each do |value|
        self.insert(value)
      end
    end

    store
  end
end
