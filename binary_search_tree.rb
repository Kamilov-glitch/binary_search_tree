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

  def insert(val, root = @root)
    if root == nil
      return root = Node.new(val)
    else 
      if val == root.data
        return root
      elsif val < root.data
        root.left = insert(val, root.left)
      else
        root.right = insert(val, root.right)
      end
    end
    @root = root
    root
  end

  def minValue(node=@root)
    current = node
    until current.left == nil
      current = current.left
    end
    current
  end

  def delete(val, root=@root)
    if root == nil
      return root
    end 
    if root.data > val
      root.left = delete(val, root.left)
    elsif root.data < val
      root.right = delete(val, root.right)
    else
      if root.left == nil
        temp = root.right
        root = nil
        return temp
      elsif root.right == nil
        temp = root.left
        root = nil
        return temp
      end
      temp = minValue(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end
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

  def inorder(root = @root, array = [])
    inorder(root.left) if root.left
    unless root == nil
      puts root.data
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

  def depth(root = @root)
    if root == nil
      return -1
    else
      left_side = height(root.left)
      right_side = height(root.right)
      if left_side > right_side
        left_side+=1
      else
        right_side+=1
      end
    end
  end

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
p new_tree.insert(22)
new_tree.insert(32832)
puts " "
new_tree.pretty_print
# new_tree.preorder
# p new_tree.inorder
# new_tree.postorder
# p new_tree.height
p new_tree.minValue
new_tree.delete(67)
new_tree.pretty_print