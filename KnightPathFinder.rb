require_relative "polytree"
require "byebug"

class KnightPathFinder
    MOVES= [[-2,-1], [-2, 1], [2,-1], [2,1], [1,2], [1,-2], [-1,2], [-1,-2]]

    def initialize(pos)
        #pos is an coordinate array e.g. [0,0]
        @root_node= PolyTreeNode.new(pos)
        @considered_positions = [pos]
    end

    def self.inbounds?(pos)
        pos.each do |x|
            return false if x>7 || x<0
        end
        true
    end

    def self.valid_moves(pos)
        valid_moves= []

        MOVES.each do |move|
            potential_pos= [pos[0]+move[0], pos[1]+move[1]]
            valid_moves << potential_pos if inbounds?(potential_pos)
        end

        valid_moves
    end

    def new_move_positions(pos)
        new_positions = self.class.valid_moves(pos).reject { |new_pos| @considered_positions.include?(new_pos)}
        @considered_positions.push(*new_positions)
        return new_positions
    end

    def build_move_tree
        queue= []
        queue.push(@root_node)
        until queue.empty?
            current_node = queue.shift
            self.new_move_positions(current_node.value).each do |new_pos|
                new_node= PolyTreeNode.new(new_pos)
                current_node.add_child(new_node)
                queue.push(new_node)
            end
        end
    end

    def find_path(end_pos)
        final_node= @root_node.bfs(end_pos)
        p final_node.value
        trace_path_back(final_node)
    end

    def trace_path_back(node)
        path = [node.value]
        until node.parent == nil
            path.unshift(node.parent.value)
            node = node.parent
        end
        path
    end
end
