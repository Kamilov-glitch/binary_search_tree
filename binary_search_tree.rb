class Node

  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

end

class Tree

  attr_accessor :array, :root

  def initialize(array)
    @array = array.sort.uniq
    @root = nil
  end

  def build_tree(start = 0, ending = (@array.length - 1),arr = @array)
    return nil if start > ending
    mid = (start+ending)/ 2
    root =  Node.new(arr[mid])
    root.left = build_tree(start, mid - 1)
    root.right = build_tree(mid + 1, ending)
    @root = root
    root
  end

  def preorder(root = @root)
    unless root == nil
      puts root.data 
    else
      return nil
    end
    preorder(root.left)
    preorder(root.right)
  end

  def inorder(root = @root)
    inorder(root.left) if root.left
    unless root == nil
      puts root.data 
    else
      return nil
    end
    inorder(root.right) if root.right
  end

  def postorder(root = @root)
    postorder(root.right) if root.right
    unless root == nil
      puts root.data 
    else
      return nil
    end
    postorder(root.left) if root.left
  end

  def height

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p arr.sort.uniq
new_tree = Tree.new(arr)
new_tree.build_tree
# p new_tree.root
new_tree.pretty_print
# new_tree.preorder
# new_tree.inorder
new_tree.postorder