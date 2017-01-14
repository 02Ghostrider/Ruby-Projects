require 'net/http'
require 'socket'
require 'json'

#Initiates and manages the user action request
def work_browser
	host = 'localhost'
	port = 3000
	choice = get_menu_choice
	case choice
	when 1
		response = do_gets(host, port)
		show_reply(response)
	when 2
		response = do_post(host, port)
		show_reply(response)
	when 3
		goodbye
	else
		puts "\n\nI'm confused!\n\n"
		goodbye
	end
end

#Manages the user input, calls for menu_display
def get_menu_choice
	menu_display
	choice = 0
	until choice > 0 && choice < 4
		print "\n\nEnter menu choice: "
		choice = gets.chomp.to_i
	end
	return choice
end

#Displays choice menu
def menu_display
	puts "\n\n" + ("~" * 40)
	puts "Browser Menu:"
	puts ("~" * 40)
	puts "1 - Request file from the server"
	puts "2 - Register Viking information"
	puts "3 - Quit"
end

#Starts the GET request process
def do_gets(host, port)
	verb = "GET"
	req_URI = get_path
	version = "HTTP/1.1"
	request = "#{verb} #{req_URI} #{version}\r\n\r\n"
	response = gets_request(host, port, request)
end

#Sends the GET request to the server
def gets_request(host, port, request)
	conduit = TCPSocket.open(host, port)
	conduit.print(request)
	response = conduit.read
end

#Prompts user to enter file name
def get_path
	print "Enter the file name to request [index.html]: "
	raw_path = gets.chomp.to_s
	if raw_path[0] == "/"
		path = raw_path
	else
		path = "/#{raw_path}"
	end
	return path
end

#Starts the POST request process
def do_post(host, port)
	verb = "POST"
	req_URI = "/raiders"
	version = "HTTP/1.1"
	raider = get_raider_info
	request = "#{verb} #{req_URI} #{version}\r\n"
	response = post_request(host, port, request, raider)
end

#Prompts user to enter the viking raider info
def get_raider_info
	puts "Please provide the following information on the viking raider."
	print "Enter the viking name: "
	vikingName = gets.chomp
	mail = false
	while mail == false
		print "\nEnter #{vikingName}'s email: "
		vikingMail = gets.chomp
		if vikingMail.include? "@"
			mail = true
		end
	end
	print "How many successful raids has #{vikingName} been on? "
	raids = gets.chomp.to_i
	if raids < 4
		vikingStrength = "Hits like a little girl"
	elsif raids >= 4 && raids < 10
		vikingStrength = "Knows which end of the sword to hold"
	else
		vikingStrength = "Strikes fear in all"
	end
	vikingInfo = {:raider => {:name => vikingName, :email => vikingMail, :strength => vikingStrength}}
end

#Formats and sends the POST request to the server
def post_request(host, port, request, raider)
	contents = raider.to_json
	size = contents.size
  entity_headers = "Content-Type: application/x-www-form-urlencoded\r\nContent-Length: #{size}"
  posting = "#{request}#{entity_headers}\r\n\r\n#{contents}"
  conduit = TCPSocket.open(host, port)
  conduit.send(posting, 0)
  response = conduit.read
end

#Displays the response from the server
def show_reply(response)
	sleep(1.5)
	puts "\n"
	reply = response.split("\r\n\r\n", 2)
	status_line = reply[0]
	status_parts = status_line.split(" ")
	code = status_parts[1]
	msg = status_parts[2]
	contents = reply[1]
	if code == "200"
		puts contents
	else
		puts code
		puts msg
	end
	sleep(2)
	check_for_more
end

#Asks user to continue or not
def check_for_more
	work_browser
end

#Shows goodbye message and ends
def goodbye
	puts "\n" + ("~" * 40)
	puts "Closing browser"
	puts "\nHave a viking nice day!"
	puts "~" * 40
	exit
end

work_browser
