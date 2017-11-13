class Node
  include Enumerable

  attr_accessor :data, :parent, :left, :right

  def initialize(data = nil, parent = nil)
    @data = data
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

end



# [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

# Get the Middle of the array and make it root.
# Recursively do same for left half and right half.
# Get the middle of left half and make it left child of the root created in step 1.
# Get the middle of right half and make it right child of the root created in step 1.