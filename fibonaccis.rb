#Two methods to return fibonacci sequence numbers

#first method uses simple iteration
def fibs(number)
	case number
	when 0
		sequence = []
	when 1
		sequence = [0]
	when 2
		sequence = [0, 1]
	else
		sequence = [0, 1, 1]
		until sequence.length == number
			sequence << sequence[-1] + sequence[-2]
		end
	end
	return sequence
end

#second method uses recursion
def fibs_rec(number)
	return [0] if number == 1
	return [0 ,1] if number == 2
	sequence = fibs_rec(number - 1)
	sequence << sequence[-1] + sequence[-2]
	return sequence
end


print fibs(10)
puts "\n"
print fibs_rec(10)

