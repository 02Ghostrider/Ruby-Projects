class Mastermind
	COLORS = ["B", "G", "O", "P", "R", "W"]

	def initialize
		@code = []
		@try = []
		@try_set = []
		@clue = []
		@clue_set = []
		@count = 0
		@win = false
		@edoc = Array.new(4)		
	end

	def random_code
		4.times { @code << COLORS[rand(6)] }
	end

	def get_code
		puts "\nEnter your code:"
		@code = gets.chomp.upcase.split("")
	end

	def instructions
		puts "\n\nWelcome to a version of Mastermind on the command line.\n"
		puts "\nThis game is much like the classic Mastermind code-breaking game.\n"
		puts "A secret, four-color code will be selected for you to guess from the following:\n"
		puts "(B)lue, (G)reen, (O)range, (P)urple, (R)ed, or (W)hite - [note colors may be repeated]\n\n"
		puts "Your task will be to guess the code by entering the letters for the colors in the correct order.\n"
		puts "You will have only 12 guesses, so choose wisely.\n\n"
		puts "To assist you with your guesses, indicators will be shown for your guess:"
		puts "(I)correct colors In correct positions or (O)correct colors Out of position"
		puts "(Just like the original game, these indicators will NOT be in corresponding order to your guess)"
	end

	def directions
		puts "\n\nWelcome Codemaster. This computer will attempt to decipher your code.\n"
		puts "\nThis will be an artificial intelligence version of the classic Mastermind game.\n"
		puts "Choose a four-color code using the first letter from the following:\n"
		puts "(B)lue, (G)reen, (O)range, (P)urple, (R)ed, or (W)hite - [note colors may be repeated]\n\n"
		puts "The computer will have 12 attempts to decipher your code."
		puts "In order for you to monitor progress of the artificial intelligence,\nindicators will be shown for each attempt:"
		puts "(I)correct colors In correct positions or (O)correct colors Out of position"
		puts "(As with the classic game, the indicators will NOT be in corresponding order to the code)"
	end

	def get_guess
		@try.clear
		until validate_guess
			puts "\nChoose from - (B)lue, (G)reen, (O)range, (P)urple, (R)ed, or (W)hite\n"
			puts "\nEnter your guess:"
			@try = gets.chomp.upcase.split("")
			validate_guess
		end
		@try_set << @try.join
		@count += 1
	end

	def ai_guess
		@try.clear
		if @count == 0
			@try = ["B", "B", "G", "G"]
		else
			@edoc.each_with_index do |x, i|
				if x == nil
					@try[i] = COLORS[rand(6)]
				else
					@try[i] = @edoc[i]
				end
			end
		end
		@try_set << @try.join
		@count += 1
	end

	def validate_guess
		if @try.length == 4 && @try.all? { |x| COLORS.include?(x) }
			return true
		elsif @try.length == 4
			puts "\n\nWhaaaaaa? That's crazy talk! Try that again."
			puts "Remember, indicate your code color choice using the first letters:"
			return false
		else
			return false
		end
	end

	def eval_guess
		unless check_win
			figure_clues
		end
	end

	def display
		12.times do |x|
			puts "-----------------"
			if @try_set[x].is_a?(String)
			 puts "  #{@try_set[x]}  |  #{@clue_set[x]}  "
			else
				puts "        |        "
			end
		end
		puts "-----------------\n"
	end

	def game_player
		random_code
		instructions
		until game_ends
			get_guess
			eval_guess
			display
		end
		farewell
	end

	def game_ai
		@ai = true
		directions
		get_code
		until game_ends
			ai_guess
			puts "\nHmmm, let me bounce my electrons around on this...\n"
			eval_guess
			display
			sleep(2)
		end
		tata_ai
	end

	def check_win
		if @code.length == 4 && @try == @code
			@clue_set << "IIII"
			@win = true
		end
	end

	def figure_clues
		@clue.clear
		kode = @code.dup
		tri = @try.dup
		4.times do |x|
			if @ai && kode[x] == tri[x]
				@edoc[x] = @code[x]
			end
			if kode[x] == tri[x]
				@clue << "I"
				kode[x] = "a"
				tri[x] = "b"
			end
		end
		4.times do |y|
			if kode.include?(tri[y])
				@clue << "O"
				kode[kode.index(tri[y])] = "d"
				tri[y] = "c"
			end
		end
		@clue_set << @clue.join
	end

	def game_ends
		if @count == 12 || check_win
			return true
		else
			return false
		end
	end

	def farewell
		if check_win 
			puts "\nYou're Brilliant! You WIN!!"
		else 
			puts "\nThanks for playing, the code was #{@code.join}."
			puts "Better luck next time."
		end
		puts "\nWell, that was exciting, yes?"	
	end

	def tata_ai
		if check_win
			puts "\nWell look at that, the computer got lucky!!"
		else
			puts "\nNicely done codemaster, the computer was not able to decipher your code: #{@code.join}"
		end
	end

	def game 
		choice = 0
		until choice == 1 || choice == 2
			puts "Hello player, will you be the (1)Codemaster or the (2)Codebreaker? (enter 1 or 2)"
			choice = gets.chomp.to_i
		end
		if choice == 1
			game_ai
		else
			game_player
		end
	end 
end


go = Mastermind.new
go.game
