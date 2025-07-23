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

      if value < node.value
        node = node.left_node
      else
        node = node.right_node
      end
    end

    if value < node.value
      node.left_node = Node.new(value)
    elsif value > node.value
      node.right_node = Node.new(value)
    end
  end

  def delete(value)
    node = @root
    next_node = @root

    until value == next_node.value
      return puts "Tree does not contain value: #{value}" if (value < node.value && node.left_node.nil?) || (value > node.value && node.right_node.nil?)

      if value < node.value
        node = next_node
        next_node = node.left_node
      else
        node = next_node
        next_node = node.right_node
      end
    end

    if value < node.value
      node.left_node = next_node
    end
  end

  def find(value)
    
  end
end