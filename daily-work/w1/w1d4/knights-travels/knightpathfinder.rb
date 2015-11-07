require_relative '00_tree_node.rb'

def reload
  load 'knightpathfinder.rb'
  load '00_tree_node.rb'
end

class KnightPathFinder
  def self.valid_moves(pos)
    results = []
    (-2..2).each do |x|
      (-2..2).each do |y|
        next if x.abs == y.abs || x == 0 || y == 0
        new_x = pos[0] + x
        new_y = pos[1] + y
        # new_x.between?(0, 7)
        if (0...8).include?(new_x) && (0...8).include?(new_y)
          results << [new_x, new_y]
        end
      end
    end
    results
  end

  attr_accessor :visited_positions, :move_tree

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = []
    @move_tree = build_move_tree
  end

  def new_move_positions(pos)
    KnightPathFinder
      .valid_moves(pos)
      .reject { |move| @visited_positions.include?(move)}
  end

  def build_move_tree
    root = PolyTreeNode.new(@starting_position)
    queue = [root]
    # self.valid_moves(@starting_position).each do |valid_move|
    until queue.empty?
      p queue.length
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |child_pos|
        new_node = PolyTreeNode.new(child_pos)
        current_node.add_child(new_node)
        @visited_positions << child_pos
      end
      queue += current_node.children
    end
    root
  end

  def find_path(end_pos)
    end_node = @move_tree.bfs(end_pos)
    p "node found"
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node
    until current_node.parent.nil? #path.last == @starting_position
      path << current_node.value
      current_node = current_node.parent
    end
    path.reverse
  end
end
