#Hangman game
#The Odin Project
#David Adams

class Hangman

	require 'yaml'

	def initialize
		puts "\nWelcome to Hangman!!\n\n"
		instructions
		start
	end

	def set_word
		file_name = "words.txt"
		@word = get_word(file_name).split("")
		hidden = Array.new(@word.length, "-")
	end

	def get_word(file_name)
		werd = ""
		until werd.length > 4 && werd.length < 13
			werd = File.readlines(file_name).sample.chomp.downcase
		end
		werd
	end

	def start
		choice = get_choice
		@bad_letters = []		
		case choice
		when 1
			hidden = set_word
			play(hidden)
		when 2
			if File.exists?("saved_game.yaml")
				hidden = get_game
				play(hidden)
			else
				hidden = set_word
				play(hidden)
			end
		when 3
			bye
		else
			puts "\nWhatza matta you, youz ain't makin sense."
			puts "This is not the game you are looking for..."
			go_away
		end
	end

	def instructions
		puts "In this game you will need to guess the letters in the word randomly selected just for you!"
		puts "You will be allowed only seven (7) incorrect guesses, so put your thinking cap on..."
	end

	def get_choice
		puts "\nPlease choose:\n\t1 - Play game\n\t2 - Load saved game\n\t3 - Quit"
		result = gets.chomp.to_i
	end

	def play(hidden)
		win = false
		until @bad_letters.length == 7 || win == true
			display(hidden)
			guess = get_letter(hidden)
			check_guess(guess, hidden)
			win = check_win(win, hidden)
		end
		if win
			congratulations
			start
		end
		if @bad_letters.length == 7
			too_bad
			start
		end
	end

	def display(hidden)
		puts "\n\n" + "+" * 75 
#puts "#{@word.join}"
		#shows the hidden word marks/letters (hidden)
		puts "\n\tGuess the #{@word.length}-letter word: #{hidden.join}" 
		#shows the number of guesses left (wrong)
		puts "\nNumber of guesses remaining: #{7 - @bad_letters.length}" 
		#shows the bad letters already guessed (@bad_letters)
		puts "Letters guessed but not in the word: #{@bad_letters.join(' ')}" 
	end

	def get_letter(hidden)
		#asks player for letter guessed
		entry = ""
		until ("a".."z").include? entry
			print "\nEnter your letter, or type 'save' to save this game: " 
			entry = gets.chomp.downcase
			if entry == "save"
				game_saver(hidden)
			end
		end
		return entry
	end

	def game_saver(hidden)
		puts "\n\nSAVING GAME"
		snapshot = [hidden, @word, @bad_letters]
		saving = File.new("saved_game.yaml", "w")
		File.open(saving, "w") do |game|
			game.write snapshot.to_yaml
		end
		sleep(1)
		bye
	end

	def get_game
		past_game = YAML.load(File.open("saved_game.yaml"))
		hidden = past_game[0]
		@word = past_game[1]
		@bad_letters = past_game[2]
		puts "\n\n---> Saved game loaded.\n\n"
		return hidden
	end

	def check_guess(guess, hidden)
	#compares guessed letter (guess) to (@word)
	#if included in (@word) then:
		#updates (hidden)
		if @word.include?(guess)
			puts "\nYes, '#{guess}' is in the word, well done!"
			update_hidden(guess, hidden)
			sleep(1.5)
	#if not included in (@word) then:
		#updates (@bad_letters)
		else
			puts "\nOh no, that'll cost you, '#{guess}' is not in the word."
			update_bad_letters(guess)
			sleep(1.5)
		end
	end

	def update_hidden(guess, hidden)
	#cycles through (@word) with index and puts (guess) in 
	#the indexed position of (hidden)
		@word.each_with_index do |ltr, i|
			if ltr == guess
				hidden[i] = @word[i]
			end
		end
	end

	def update_bad_letters(guess)
		@bad_letters << guess
		@bad_letters.uniq! #takes care of duplicates
	end

	def check_win(win, hidden)
	#compares (hidden) to (@word)
	#if they match (win) == true
		if @word == hidden
			win = true
	#else (win) remains false
		else
			win = false
		end
		return win
	end

	def congratulations
	#shows atta_boy for guessing the (@word) and displays 
	#remaining (wrong) guesses to spare
		puts "\n\n"
		puts "! " * 40
		puts "\nCongratulations, you correctly guessed the word '#{@word.join}'!\nAnd with #{7 - @bad_letters.length} guesses to spare!\n"
	end

	def too_bad
	#better luck next time, too bad you didn't figure out the (@word)
		puts "\n\n" + "#" * 75
		puts "\n     * *\n      ~"
		puts "\nToo bad, you got all hung up. The word you didn't guess is #{@word.join}.\n"
	end

	def bye
		puts "\n\nGAME OVER!\n\nThat was so much fun! TTFN!"
		exit
	end

	def go_away
		puts "\nThese are not the droids we're looking for;\nMove along, move along..."
	end

end

Hangman.new
