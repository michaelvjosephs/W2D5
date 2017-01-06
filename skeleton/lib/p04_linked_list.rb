require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  include Enumerable

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
    self.next = nil
    self.prev = nil
  end
end

class LinkedList

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
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
    current_node = first
    # debugger
    until current_node == tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end

    nil
  end

  def include?(key)
    current_node = first

    until current_node == tail
      return true if current_node.key == key
      current_node = current_node.next
    end

    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    new_link.next = tail

    empty? ? @head.next = new_link : last.next = new_link

    @tail.prev = new_link
  end

  def update(key, val)
    current_node = first

    until current_node == tail
      current_node.val = val if current_node.key == key
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = first

    until current_node == tail
      # debugger
      if current_node.key == key
        current_node.remove
        break
      else
        current_node = current_node.next
      end
    end
  end

  def each(&prc)
    current_node = first

    until current_node == tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
