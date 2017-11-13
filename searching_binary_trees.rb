class Node
  include Enumerable

  attr_accessor :data, :parent, :left, :right

  def initialize(data = nil, parent = nil)
    @data = data
  end

  def each(&block)
    # self.children[:left] evaluates to true if there exists a child
    left.each(&block) if left
    block.call(self)
    right.each(&block) if right
  end

  def <=>(other_node)
    self.data <=> other_node.data
  end
  
end

class Binary_Tree
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
    endi
  end

end



# [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

# Get the Middle of the array and make it root.
# Recursively do same for left half and right half.
# Get the middle of left half and make it left child of the root created in step 1.
# Get the middle of right half and make it right child of the root created in step 1.