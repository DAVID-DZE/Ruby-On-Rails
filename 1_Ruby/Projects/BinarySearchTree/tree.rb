require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


  def insert(value)
    @root = insert_into_node(@root, value)
  end

  def delete(value)
    @root = delete_from_node(@root, value)
  end

  def find(value)
    find_in_node(@root, value)
  end

  def level_order(queue = [@root], &block)
    return [] if @root.nil? || queue.empty?

    node = queue.shift

    yield node if block_given?
    values = [node.value]

    queue << node.left if node.left
    queue << node.right if node.right

    block_given? ? level_order(queue, &block) : values + level_order(queue, &block)
  end

  def inorder(node = @root, values = [], &block)
    return values if node.nil?

    inorder(node.left, values, &block)

    yield node if block_given?
    values << node.value

    inorder(node.right, values, &block)

    block_given? ? self : values
  end

  def preorder(node = @root, values = [], &block)
    return values if node.nil?

    yield node if block_given?
    values << node.value

    preorder(node.left, values, &block)
    preorder(node.right, values, &block)

    block_given? ? self : values
  end

  def postorder(node = @root, values =[], &block)
    return values if node.nil?

    postorder(node.left, values, &block)
    postorder(node.right, values, &block)
    yield node if block_given?
    values << node.value

    block_given? ? self : values
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, current_node = @root, depth = 0)
    return nil if current_node.nil?

    return depth if node == current_node

    depth += 1
    left_depth = depth(current_node.left, node, depth)
    right_depth = depth(current_node.right, node, depth)

    left_depth || right_depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    @root = build_tree(level_order)
  end

  private

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    root = Node.new(array[middle])
    root.left = build_tree(array[0...middle])
    root.right = build_tree(array[middle + 1..-1])

    root
  end

  def insert_into_node(node, value)
    return Node.new(value) unless node

    if value < node.value
      node.left = insert_into_node(node.left, value)
    elsif value > node.value
      node.right = insert_into_node(node.right, value)
    end

    node
  end

  def delete_from_node(node, value)
    return nil unless node

    if value < node.value
      node.left = delete_from_node(node.left, value)
    elsif value > node.value
      node.right = delete_from_node(node.right, value)
    else
      if node.left.nil? && node.right.nil?
        node = nil
      elsif node.right.nil?
        node = node.left
      elsif node.left.nil?
        node = node.right
      else
        leftmost_node = find_min_value_node(node.right)
        node.value = leftmost_node.value
        node.right = delete_from_node(node.right, leftmost_node.value)
      end
    end

    node
  end

  def find_min_value_node(node)
    current_node = node

    while current_node.left
      current_node = current_node.left
    end

    current_node
  end

  def find_in_node(node, value)
    return nil unless node

    if value < node.value
      find_in_node(node.left, value)
    elsif value > node.value
      find_in_node(node.right, value)
    else
      node
    end
  end

end


# Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15) { rand(1..100) })

# Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"

# Unbalance the tree by adding several numbers > 100
tree.insert(105)
tree.insert(120)
tree.insert(130)

# Confirm that the tree is unbalanced
puts "Is the tree balanced after adding elements? #{tree.balanced?}"

# Balance the tree
tree.rebalance

# Confirm that the tree is balanced
puts "Is the tree balanced after rebalancing? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level order after rebalancing: #{tree.level_order}"
puts "Preorder after rebalancing: #{tree.preorder}"
puts "Postorder after rebalancing: #{tree.postorder}"
puts "Inorder after rebalancing: #{tree.inorder}"
