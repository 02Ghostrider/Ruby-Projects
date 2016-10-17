#bubble_sort_by

def bubble_sort_by(sortof)
	clean = false

	while clean == false
		clean = true
		m = sortof.length - 1

		m.times do |x|
			if (yield sortof[x], sortof[x+1]) > 0
				sortof[x], sortof[x+1]= sortof[x+1], sortof[x]
				clean = false
			end
		end
	end

	return sortof

end

test_array = ["hi", "hello", "hey"]
puts "The test array is " + test_array.to_s
orderly = bubble_sort_by(test_array) {|left, right| left.length - right.length}
puts "The sorted array is " + orderly.to_s
