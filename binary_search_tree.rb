class Node

  def initialize(data, left, right)
    @data = data
    @left = start
    @right = ending
  end

end

class Tree

  def initialize(array, start, ending)
    @array = array
    @start = start
    @ending = ending
    @root = nil
  end

  def build_tree
    @array = @array.sort
    @array = @array.each_with_index { |e, indx| @array.delete_at(indx) if e == @array[indx - 1] }
    @array
  end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
new_tree = Tree.new(arr, 0, arr.length - 1)
p new_tree.build_tree