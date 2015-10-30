class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    @parent.children.delete(self) if @parent
    unless new_parent.nil? || new_parent.children.include?(self)
      @parent = new_parent
      new_parent.children.push(self)
    else
      @parent = nil
    end
  end

  def add_child(child_node)
    unless children.include?(child_node)
      child_node.parent = self
    end
  end

  def remove_child(child_node)
    raise "Error" unless children.include?(child_node)
    children.delete(child_node)
    child_node.parent = nil
  end


  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      child_res = child.dfs(target_value)
      return child_res if child_res
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return value if current.value == target_value
      queue += children
    end
  end
end
