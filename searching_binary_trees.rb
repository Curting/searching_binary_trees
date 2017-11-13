class Node
  include Enumerable

  attr_accessor :data, :parent, :left, :right

  def initialize(data = nil, parent = nil)
    @data = data
  end

  def each(&block)
    # left and/or right evaluates to true if the child exists
    left.each(&block) if left
    block.call(self)
    right.each(&block) if right
  end

  def <=>(other_node)
    self.data <=> other_node.data
  end
end

class Binary_Tree
  attr_accessor :root

  def build_tree(ary)
    ary.shuffle!
    @root = Node.new(ary.shift)

    ary.each do |e|
      insert_node(e)
    end
  end

  def insert_node(data, node = @root)
    if data < node.data
      if node.left.nil?
        node.left = Node.new(data)
        node.left.parent = node
      else
        insert_node(data, node.left)
      end
    else
      # data >= node.data
      if node.right.nil?
        node.right = Node.new(data)
        node.right.parent = node
      else
        insert_node(data, node.right)
      end
    end
  end

  def to_s
    string = ""
    @root.each {|e| string << "#{e.data}, "}
    string[0..-3]
  end

  def breadth_first_search(data, queue = [@root])
    # Queue: Add elements to the back and remove from the front
    current = queue.shift

    if data == current.data
      current
    else
      # Add potential left child to queue
      queue << current.left unless current.left.nil?

      # Add potential right child to queue
      queue << current.right unless current.right.nil?

      # Time for some recursion
      breadth_first_search(data, queue) unless queue.empty?
    end
  end

  def depth_first_search(data)
    # A truer-to-nature approach would be LDR, but I'm going with DLR here. Less headache.
    # Stack: Add elements to the top and remove from the top
    stack = [@root]

    until stack.empty?
      # Pick element from the top
      node = stack.pop

      # Return the element if it's what we're looking for
      return node if node.data == data

      # If not... Go on looking at the children.
      stack.push(node.left) if node.left
      stack.push(node.right) if node.right
    end
  end

  # I've used the Enumerables module in the following method.
  # I don't know if it's cheating but I learned quite a lot from it:
  def dfs_rec(data)
    @root.each { |node| return node if data == node.data }
  end
end

# Create a Binary Tree from an array
tree = Binary_Tree.new
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

# Test if the #build_tree method worked
puts tree.to_s # => "1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345"

# Breadth First Search
puts tree.breadth_first_search(7) # => #<Node:0x007...>
puts tree.breadth_first_search(666).inspect # => nil

# Depth First Search
puts tree.depth_first_search(23) # => #<Node:0x007...>
puts tree.depth_first_search(0).inspect # => nil

# Depth First Search - recursion (in the each method)
puts tree.dfs_rec(67) # => #<Node:0x007...>
puts tree.dfs_rec(555).inspect # => nil



