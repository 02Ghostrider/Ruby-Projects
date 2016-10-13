#P3 Substrings

def substrings(string, valid_words)
	@hashorama = Hash.new(0)
	words = string.downcase.split
	checking = Array.new(0)

	words.each do |word| 
		checking += possibilities(word)
	end

	checking.each do |part|
		if valid_words.include?(part)
			@hashorama[part] += 1
		end
	end
	
	return @hashorama
end

def possibilities(single_string)

	werd = single_string.split("")
	front = 0
	back = 0
	possibles = Array.new(0)

	until back == werd.length
		possibles << werd[front..back].join
		back += 1
		if back == werd.length
			front += 1
			back = front
		end
	end

	return possibles

end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

single_text = "below"
substrings(single_text, dictionary)
puts "The word 'below' evaluates to:"
puts @hashorama

multi_text = "Howdy partner, sit down! How's it going?"
substrings(multi_text, dictionary)
puts "The phrase: 'Howdy partner, sit down! How's it going?' evaluates to:"
puts @hashorama

puts "Enter text:"
some_text = gets.chomp
substrings(some_text, dictionary)
puts @hashorama
