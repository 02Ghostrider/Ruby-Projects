#Linked list project

#Represents the full list

class Node
	
	attr_accessor :value, :next_node

	#Value and next_node set to 'nil' by default
	def initialize(value = nil, next_node = nil)
		@value = value
		@next_node = next_node
	end

end

class LinkedList < Node
	def initialize
		@head = nil
		@tail = nil
	end

	#Adds a new node to the end of the list
	def append(val)
		adding = Node.new(val)
		if @head == nil
			@head = adding
			@tail = adding
		else
			current = @head
			until current.next_node == nil
			current = current.next_node
			end
			current.next_node = adding
			@tail = adding
		end
	end

	#Adds a new node to the start of the list
	def prepend(val)
		if @head == nil
			@head = Node.new(val, nil)
			@tail = @head
		else
			@head = Node.new(val, @head)
		end
	end

	#Returns the total number of nodes in a list
	def size
		if @head == nil
			count = 0
		else
			count = 1
			current = @head
			until current.next_node == nil
				current = current.next_node
				count += 1
			end
		end
		return count
	end

	#Returns the first node in the list
	def head
		if @head == nil
			return nil
		else
			return @head.value
		end
	end

	#Returns the last node in the list
	def tail
		if @tail == nil
			return nil
		else
			return @tail.value
		end
	end

	#Returns the node at the given index
	def at(index)
		count = 0
		current = @head
		until count == index || current.next_node == nil
			current = current.next_node
			count += 1
		end
		if count == index
			return current
		else
			return puts "#{index} is out of bounds for the list"
		end
	end

	#Removes the last element from the list
	def pop
		count = self.size
		if count > 1
			current = @head
			until current.next_node == nil
				prev = current
				current = current.next_node
			end
			@tail = prev
			prev.next_node = nil
			puts "The last element, #{current.value}, has been removed from the list."
		else
			puts "#{@head.value} has been removed and the list is empty."
			@head = nil
			@tail = nil
		end
	end

	#Returns 'true' if the passed in value is in the list
	#Returns 'false' if the passed in value is not in the list
	def contains?(val, current = @head)
		until current == @tail.next_node
			if current.value == val
				return true
			end
			current = current.next_node
		end
		return false
	end

	#Returns the index of the node containing data,
	#or 'nil' if data was not found
	def find(data, current = @head, count = 0)
		until current == @tail.next_node
			if current.value == data
				return count
			end
			count += 1
			current = current.next_node
		end
		puts "#{data} not found in the list"
	end

	#Represents LinkedList objects as strings to print out or
	#preview them in the conslole. Format is:
	#   ( data ) -> ( data ) -> ( data ) -> nil
	def to_s
		if @head == nil
			puts "Nothin in the list..."
			return
		else
			current = @head
			puts ""
			until current == @tail.next_node
				print "( #{current.value.to_s} ) -> "
				current = current.next_node
			end
			print "nil\n"
		end
	end

	#Inserts data at a given index
	def insert_at(data, index)
		if index == 0
			prepend(data)
		elsif index == 1
			current = Node.new(data, @head.next_node)
			@head.next_node = current
		else
			prev = at(index-1)
			follow = at(index)
			current = Node.new(data, follow)
			prev.next_node = current
		end
	end

	#Removes a node at the given index
	def remove_at(index)
		goner = at(index)
		if goner == @tail
			self.pop
		elsif goner == @head
			@head = at(index+1)
		else
			prev = at(index-1)
			follow = at(index+1)
			prev.next_node = follow
		end
	end

end

names = LinkedList.new
names.prepend("David")
names.append("Susan")
names.insert_at("Ranger", 1)
names.insert_at("Rachel", 2)
names.append("Maggie")
names.to_s
puts names.contains?("Maggie")

