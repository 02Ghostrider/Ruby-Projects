#Merge sorter

def merge_sort(initialArray)
#Base case
	if initialArray.size < 2
		return initialArray
	end
#split initialArray in half and sort each
	mid = initialArray.size / 2
	front = merge_sort(initialArray[0..mid-1])
	back = merge_sort(initialArray[mid..-1])
	result = assemble(front, back)
end

def assemble(one, other)
	midArray = []
	while one.size > 0 && other.size > 0
		if one.first < other.first
			midArray << one.first
			one.shift
		else
			midArray << other.first
			other.shift
		end
	end
	while one.size > 0
		midArray << one.first
		one.shift
	end
	while other.size > 0
		midArray << other.first
		other.shift
	end
	return midArray
end


set = []
20.times do
	set << (rand * 500).to_i
end

puts "Initial number set is:\n#{set}\n\n"
sorted = merge_sort(set)
puts "Sorted number set is:\n#{sorted}"
