def caesar_cypher (raw_string, heat)
	rare_array = raw_string.codepoints

	med_array = []
	@well_array = []

	rare_array.each do |i|
		if ((97..122).include?(i) && (i+heat)>122) || ((65..90).include?(i) && (i+heat)>90)
			med = i + heat - 26
		elsif (97..122).include?(i + heat) || (65..90).include?(i + heat)
			med = i + heat
		else
			med = i
		end 
		med_array << med
	end
	@well_done = med_array.pack("C*")
end

puts "Enter text:"
string_in = gets.chomp
puts "Key value:"
key = gets.chomp.to_i
caesar_cypher(string_in, key)
puts @well_done
