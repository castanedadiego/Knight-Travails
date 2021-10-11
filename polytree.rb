class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value= nil)
        @value||= value
        @parent= nil
        @children= []
    end

    def parent=(node)
        if node
            @parent.children.reject! {|child| child == self} unless @parent == nil
            @parent= node
            node.children << self unless node.children.include?(self)
        else
            @parent= nil
        end
    end

    def add_child(child)
        child.parent= self
    end

    def remove_child(child)
        if self.children.include?(child)
            child.parent = nil
        else
            raise "not a child"
        end
    end

    def dfs(target_value)
        if self.value == target_value
            return self
        end
        children.each do |child|
            search_result= child.dfs(target_value)
            return search_result unless search_result == nil
        end
        nil
    end

    def bfs(target_value)
        array= []
        array.push(self)
        until array.empty?
            current_node= array.shift
            return current_node if current_node.value == target_value
            array.push(*current_node.children)
        end
    end
end
