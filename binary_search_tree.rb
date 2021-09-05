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

  def find(val, node = @root)
    if node != nil
      if node.data == val
      found_node = node
      return found_node
      else
        found_node = find(val, node.left)
        if found_node == nil
          found_node = find(val, node.right)
        end
      end
    end
    found_node
  end

  def level_order(root=@root)
    return root if root == nil
    array = []
    queue = []
    queue.push(root)
    until queue.empty?
      current = queue[0]
      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
      array.push(queue.shift.data)
    end
    array
  end

  def level_order_rec(node = @root, queue = [], array = [])
    return array if node == nil
    array.push(node.data)
    queue.push(node.left) if node.left
    queue.push(node.right) if node.right

    level_order_rec(queue.shift, queue, array)
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

  def height(node = @root)
    if node == nil
      return -1
    else
      left_side = height(node.left)
      right_side = height(node.right)
      if left_side > right_side
        left_side+=1
      else
        right_side+=1
      end
    end
  end

  def depth(val = @root.data, root = @root, dist = 0)
    if root == nil
      return -1
    end
    if root.data == val
      0
    end
    if val < root.data
      dist = depth(val, root.left)
      dist+=1
    elsif val > root.data
      dist = depth(val, root.right)
      dist+=1
    end
    dist
  end

  def balanced(root = @root)
    [height(root.left), height(root.right)].max - [height(root.left), height(root.right)].min <= 1
  end

  def rebalance(root = @root)
    @array = level_order(root).sort.uniq
    @root = build_tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


end

arr = Array.new(15){rand(1..100)}
p arr.sort.uniq
new_tree = Tree.new(arr)
new_tree.build_tree
# p new_tree.root
# new_tree.pretty_print
# p new_tree.insert(22)
# new_tree.insert(32832)
# puts " "
# new_tree.pretty_print
# new_tree.preorder
# p new_tree.inorder
# new_tree.postorder
# p new_tree.height
# p new_tree.minValue
# new_tree.delete(67)
# new_tree.pretty_print
# p new_tree.find(1)
# p new_tree.level_order
# p new_tree.level_order_rec()
# p new_tree.depth(7)
p new_tree.balanced
puts "Preorder traversal"
new_tree.preorder
puts "Inorder"
new_tree.inorder
puts "Postorder"
new_tree.postorder
new_tree.insert(103)
new_tree.insert(122)
new_tree.insert(256)
p new_tree.balanced
new_tree.rebalance
p new_tree.balanced
puts "Preorder traversal"
new_tree.preorder
puts "Inorder"
new_tree.inorder
puts "Postorder"
new_tree.postorder
new_tree.pretty_print
