#Binary Tree Search

class Node

	attr_accessor :value, :parent, :leftChild, :rightChild

	def initialize (value, parent = nil, rightChild = nil, leftChild = nil)
		@value = value
		@parent = parent
		@rightChild = rightChild
		@leftChild = leftChild
	end

end

class BinTree < Node

	attr_accessor :root

	#Starts the process to take an input array and build a binary
	#search tree with the data (assumes dataSet is sorted)
	def initialize(dataSet)
		mid = dataSet.size/2
		seed = dataSet.slice!(mid)
		@root = Node.new(seed)
		build_tree(dataSet)
	end

	#Takes data array then builds a binary search tree 
	def build_tree(dataSet)
		dataSet.each do |value|
			make_branch(value)
		end
	end

	#takes the value from dataSet to set into the node with
	#links to parent, rightChild, and leftChild as appropriate
	#the leftChild(ren) < root/parent and 
	#the rightChild(ren) >= root/parent	
	def make_branch(value, node = @root)
		if value < node.value
			if node.leftChild == nil
				node.leftChild = Node.new(value, node)
			else
				make_branch(value, node.leftChild)
			end
		else #value >= node.value
			if node.rightChild == nil
				node.rightChild = Node.new(value, node)
			else
				make_branch(value, node.rightChild)
			end
		end
	end

	#Returns the node of the search value using 'breadth first search'
	#returns nil if search value is not found
	def bfs(val)
		queue = [@root]
		until queue.empty? 		
			current = queue.shift
			if current.value == val
				return current
			end
			if current.leftChild != nil
				queue << current.leftChild
			end
			if current.rightChild != nil
				queue << current.rightChild
			end
		end
		nil
	end

	#Returns the node of the search value using 'depth first search'
	#returns nil if search value is not found
	#uses Inorder search, LDR
	def dfs(val)
		stack = [@root]
		current = @root
		checked = []
		while stack.length > 0
			until current.leftChild == nil || checked.include?(current.leftChild)
				stack << current.leftChild
				current = current.leftChild
			end
			check = stack.pop
			if check.value == val
				return check
			elsif check.rightChild != nil
				stack << check.rightChild
			end
			checked << check
			current = stack.last unless stack.length == 0
		end
		nil
	end

	#Depth first search with recursion
	#returns nil if search value is not found
	def dfs_rec(val, current = @root)
		if current.value == val
			return current
		end
		if current.leftChild != nil
			find = dfs_rec(val, current.leftChild)
			return find unless find.nil?
		end
		if current.rightChild != nil
			find = dfs_rec(val, current.rightChild)
			return find unless find.nil?
		end
		nil
	end

end

dataSet = [14, 3, 4, 13, 12, 16, 11, 7, 8, 1, 9, 6, 2, 5, 15, 10]
tree = BinTree.new(dataSet)
puts tree.bfs(3)
puts tree.dfs(3)
puts tree.dfs_rec(3)

