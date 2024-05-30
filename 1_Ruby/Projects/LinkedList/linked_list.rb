require_relative 'node'

class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
    @size +=1
  end

  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next_node = @head
      @head = new_node
    end
    @size +=1
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def size
    @size
  end

  def at(index)
    return nil if @size <= index
    new_node = @head
    index.times { current_node = new_node.next_node }
    current_node
  end

  def pop
    return nil if @size.zero?
    if @size == 1
      @head = nil
      @tail = nil
    else
      current_node = @head
      (@size - 2).times { current_node = current_node.next_node }
      @tail = current_node
      @tail.next_node = nil
    end
    @size -= 1
  end

  def contains?(value)
    current_node = @head
    while current_node
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    current_node = @head
    index = 0
    while current_node
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    nil
  end

  def to_s
    current_node = @head
    str = ""
    while current_node
      str += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    str += "nil"
    str
  end

  def insert_at(value, index)
    return nil if index > @size
    new_node = Node.new(value)
    if index.zero?
      new_node.next_node = @head
      @head = new_node
    else
      previous_node = at(index - 1)
      new_node.next_node = previous_node.next_node
      previous_node.next_node = new_node
    end
    @size += 1
  end

end
