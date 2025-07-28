class Node
  attr_accessor :value, :left_node, :right_node

  def initialize(value = 0, left_node = nil, right_node = nil)
    @value = value
    @left_node = left_node
    @right_node = right_node
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(arr)
    return if arr.empty?

    mid = arr.length/2
    root = Node.new(arr[mid])
    root.left_node = build_tree(arr[0...mid])
    root.right_node = build_tree(arr[mid+1..])

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

  def insert(value)
    node = @root

    until (value < node.value && node.left_node.nil?) || (value > node.value && node.right_node.nil?)
      return puts "Tree already contains '#{value}" if value == node.value

      node = value < node.value ? node.left_node : node = node.right_node
    end

    if value < node.value
      node.left_node = Node.new(value)
    elsif value > node.value
      node.right_node = Node.new(value)
    end
  end

  def delete(value)
    node = @root

    until value == node.value
      return puts "Tree does not contain value: #{value}" if (value < node.value && node.left_node.nil?) || (value > node.value && node.right_node.nil?)
      parent = node
      node = value < node.value ? node.left_node : node.right_node
    end

    #This block is performed unless value is a leaf node
    unless node.left_node.nil? && node.right_node.nil?
      replacement = node.right_node.nil? ? node.left_node : node.right_node 

      while replacement.left_node || replacement.right_node
        parent = replacement
        replacement = replacement.left_node.nil? ? replacement.right_node : replacement.left_node
      end

      new_value = replacement.value
      node.value = new_value
    end

    value < parent.value ? parent.left_node = nil : parent.right_node = nil
  end

  def find(value)
    node = @root

    until value == node.value
      return puts "Tree does not contain value: #{value}" if (value < node.value && node.left_node.nil?) || (value > node.value && node.right_node.nil?)
      node = value < node.value ? node.left_node : node.right_node
    end

    return node
  end

  def nodes_in_level(node, level)
    
  end

  def level_order
    queue = [@root]
    breadth_values = []

    until queue.empty?
      temp = []
      queue.each do |node|
        yield(node) if block_given?
        breadth_values << node.value
        temp << node.left_node if node.left_node
        temp << node.right_node if node.right_node
      end
      queue = temp
    end

    return breadth_values
  end

  def preorder(node = @root, preorder_values = [])
    return if node.nil?
    yield(node) if block_given?

    preorder_values << node.value
    preorder(node.left_node, preorder_values)
    preorder(node.right_node, preorder_values)

    return preorder_values
  end

  def inorder(node = @root, inorder_values = [])
    return if node.nil?

    inorder(node.left_node, inorder_values)
    inorder_values << node.value
    yield(node) if block_given?
    inorder(node.right_node, inorder_values)

    return inorder_values
  end

  def postorder(node = @root, postorder_values  = [])
    return if node.nil?

    postorder(node.left_node, postorder_values)
    postorder(node.right_node, postorder_values)

    postorder_values << node.value
    yield(node) if block_given?

    return postorder_values
  end

  def height_dig(node, height)
    return height -= 1 if node.nil?
    
    left_height = height_dig(node.left_node, height += 1)
    height -= 1
    right_height = height_dig(node.right_node, height += 1)

    height -= 1
    if left_height > right_height
      return left_height
    else
      return right_height
    end
  end

  def height(value)
    node = @root
    max_height = 0

    until value == node.value
      node = value < node.value ? node.left_node : node.right_node
      return nil if node.nil?
    end

    max_height = height_dig(node, max_height)

    return max_height
  end

  def depth(value)
    node = @root
    depth = 0

    until value == node.value
      node = value < node.value ? node.left_node : node.right_node
      depth += 1
      return nil if node.nil?
    end

    return depth
  end
end