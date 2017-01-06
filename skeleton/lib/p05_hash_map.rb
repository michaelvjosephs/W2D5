require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require "byebug"

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    # debugger
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if count == @store.length
      bucket(key).append(key, val)
      @count += 1
    end

  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    helper = @store
    new_count = num_buckets * 2
    @store = Array.new(new_count) { LinkedList.new }
    @count = 0

    # debugger
    helper.each do |list|
      list.each do |node|
        set(node.key, node.val)
      end
    end

    @store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
#
# h = HashMap.new(2)
# h.set("hello", 1)
# h.set("goodbye", 2)
# p h.store.length
# h.set("resized?", 3)
# p h.store.length
