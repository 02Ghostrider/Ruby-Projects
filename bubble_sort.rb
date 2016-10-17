#bubble_sort

def bubble_sort(sortof)
	clean = false

	while clean == false
		clean = true
		m = sortof.length - 1

		m.times do |x|
			if sortof[x] > sortof[x+1]
				sortof[x], sortof[x+1]= sortof[x+1], sortof[x]
				clean = false
			end
		end
	end

	return sortof

end

test_array = [4,3,78,2,0,2]
puts "The test array is " + test_array.to_s
orderly = bubble_sort(test_array)
puts "The sorted array is " + orderly.to_s
