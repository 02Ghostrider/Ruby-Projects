require 'socket'                # Get sockets from stdlib

# Do parsing on the incoming message to determine
# the verb, and path for the request
def processing(incoming)
	verb = get_verb(incoming)
  case verb
  when "GET"
    resource = get_resource(incoming)
    verify = check_resource(resource)
    if verify
      response = good_request(resource)
    else
      response = bad_request(resource)
    end
  else
    response = crazy_request
  end
  return response
end

# split off the verb from the incoming request
def get_verb(incoming)
  verb = incoming.split[0]
end

# deal with a bad request, send back code and message
def bad_request(resource)
  status_line = "HTTP/1.1 404 File Not Found\r\n"
  contents = "File not found: #{resource} NO SOUP FOR YOU!"
  size = contents.size
  entity_headers = "Content-Type: text/html\r\nContent-Length: #{size}\r\n"
  responding = status_line + entity_headers + "\r\n" + contents
end

# split off the resource from the incoming request
def get_resource(incoming)
  path = incoming.split[1]
  if path[0] = "/"
    resource = path[1..-1]
  else
    resource = path
  end
  return resource
end

# check that requested file exists
def check_resource(resource)
  if File.exists?(resource)
    verify = true
  else
    verify = false
  end
end

# return status code 200, resource contents, and resource size
def good_request(resource)
  status_line = "HTTP/1.1 200 OK\r\n"
  size = File.size(resource)
  entity_headers = "Content-Type: text/html\r\nContent-Length: #{size}\r\n"
  contents = File.read(resource)
  responding = status_line + entity_headers + "\r\n" + contents
end

# return message if verb is unknown
def crazy_request
  status_line = "HTTP/1.1 400 Bad Request\r\n"
  contents = "The server could not understand you!"
  size = contents.size
  entity_headers = "Content-Type: text/html\r\nContent-Length: #{size}\r\n"
  responding = status_line + entity_headers + "\r\n" + contents
end


# Socket to listen on port 3000
server = TCPServer.open(3000) 

# Servers run forever  
loop do                          
  Thread.start(server.accept) do |client|
  	# Get request message from client
    incoming = client.recv(5000)
    # process incoming to for a GET pointing to /index.html
    outgoing = processing(incoming)
    # response to the client request
		client.puts outgoing
		# Disconnect from the client
    client.close                
  end
end
