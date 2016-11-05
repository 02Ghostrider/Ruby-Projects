class Game

	def initialize
		@@person_x = Array.new(2)
		@@person_o = Array.new(2)
		@@grid = Array.new(9)
	end

	def control
		start_up
		rules
		new_game
		display_board(@@grid)
		play
	end

	private

	def play
		round = 1
		winner = nil
		until round > 9 || winner
			chooser = switch_player(round)
			move = choose_move(chooser)
			mark = chooser[1]
			board_update(move, chooser[1])
			display_board(@@grid)
			winner = check_for_win(chooser)
			round += 1
		end
		game_ends(winner)
	end

	def display_board(grid)
		puts "   |   |   "
		puts " #{grid[0]} | #{grid[1]} | #{grid[2]} "
		puts "___|___|___"
		puts "   |   |   "
		puts " #{grid[3]} | #{grid[4]} | #{grid[5]} "
		puts "___|___|___"
		puts "   |   |   "
		puts " #{grid[6]} | #{grid[7]} | #{grid[8]} "
		puts "   |   |   "		
	end

	def new_board(grid)
		grid = grid.each_index { |a| grid[a] = (a + 1)}
	end

	def new_game
		@@grid = new_board(@@grid)
	end

	def rules
		puts "The rules are simple:"
		puts "- Enter the number of the position you choose as shown on the grid"
		puts "- Once you choose a position, your mark will replace the number on the grid"
		puts "- Get three in a row, either vertically, diagonally, or horizontally to win"
		puts "\nEnter 'Y' to accept these rules and play, \nor enter 'N' to aknowledge your inferior intellect and move on"
		a = gets.chomp.downcase
		if a == "y"
			return
		else
			puts "\n\nTake a hike...\n\nLOOSERS\n\n"
			game_ends(nil)
		end
	end

	def start_up
		puts "\nWelcome to Tic-Tac-Toe on the command prompt!!"
		puts "Brought to you today by Ruby :-)"
		puts "\nPlayer 1 - Enter your name:"
		@@person_x[0] = gets.chomp.downcase.capitalize
		@@person_x[1] = "X"
		puts "\nPlayer 2 - Enter your name:"
		@@person_o[0] = gets.chomp.downcase.capitalize
		@@person_o[1] = "O"
		puts "\nOK, #{@@person_x[0]} and #{@@person_o[0]}, are you ready to zig, zag, ..er.. tig, tag, ..um.. play? (enter)"
		gets
		puts "\n"
	end

	def validate_move(move, chooser)
		if @@grid[move].is_a? Integer
			chooser << (move + 1)
		else
			puts "That one is in play already, try again, looser."
			choose_move(chooser)
		end
	end

	def board_update(place, mark)
		@@grid[place.last - 1] = mark
	end

	def check_for_win(chooser)
		wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		check = chooser.find_all { |i| i.is_a? Integer }
		if wins.any? { |set| set.all? { |a| check.include?(a) } }
			return chooser[0]
		else
			return false
		end
	end

	def game_ends(winner)
		if winner
			puts "\n#{winner} wins!"
		else
			puts "\nNo winner, just whiners..."
			exit
		end
	end

	def switch_player(round)
		if round % 2 != 0 
			chooser = @@person_x
		else
			chooser = @@person_o
		end
	end

	def choose_move(chooser)
		puts "\n#{chooser[0]} choose your move by entering the position number from the grid"
		move = gets.chomp.to_i - 1
		validate_move(move, chooser)
	end
end

go = Game.new
go.control
