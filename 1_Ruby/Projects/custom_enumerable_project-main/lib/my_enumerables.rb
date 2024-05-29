module Enumerable
  def my_each_with_index
    index = -1
    my_each { |element| yield(element, index += 1) }
  end

  def my_select
    result = []
    my_each { |element| result.push(element) if yield(element) }
    result
  end

  def my_all?
    my_each { |element| return false unless yield(element) }
    true
  end

  def my_any?
    my_each { |element| return true if yield(element) }
    false
  end

  def my_none?
    my_each { |element| return false if yield(element) }
    true
  end

  def my_count
    if block_given?
      count = 0
      my_each { |element| count += 1 if yield(element) }
      return count
    end
    size
  end

  def my_map
    map = []
    my_each { |element| map.push(yield(element)) }
    map
  end

  def my_inject(initial_value)
    total = initial_value
    my_each{ |element| total = yield(total, element) }
    total
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for element in self
      yield element
    end
  end
end
