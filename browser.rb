# The library we need
require 'net/http'
# The web server                  
host = 'localhost'    			 				
# The file we want
path = '/index.html'                 
# port is 3000
port = 3000
# Create a connection
http = Net::HTTP.new(host, port)    
# Request the file
content = http.get(path)      
# Check the status code
if content.code == "200"               
  puts content.code
  puts content.message
  puts content.body                  
else                                
  puts content.code
  puts content.message
  puts content.body
end
