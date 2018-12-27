# 1. CERN httpd (later also known as W3C httpd)
# 2. NCSA HTTPd: among the earliest web servers developed, following Tim Berners-Lee's CERN httpd, Tony Sanders' Plexus server, and some others. It was for some time the natural counterpart to the *Mosaic* web browser (popularized internet protocols such as FTP) in the client–server World Wide Web. 
# 3. Apache HTTP Server: Originally based on the NCSA HTTPd server

require "byebug"
require "socket" # https://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/TCPServer.html
server = TCPServer.new(5678)

# `localhost`: Remote Address: [::1]:5678
# `http://127.0.0.1` Remote Address: 127.0.0.1:5678

loop do
	Thread.start(server.accept) do |session|
	  request = session.gets # "GET / HTTP/1.1\r\n"; and then "GET /favicon.ico HTTP/1.1\r\n"

	  session.print "HTTP/1.1 200\r\n" # 1
	  # RESPONSE HEADERS
	  session.print "Content-Type: text/html\r\n" # 2
	  session.print "\r\n" # 3
	  session.print "Hello world! The time is #{Time.now}\r\n" #4
	  sleep 1
	  # Queueing up the requests:
	  # FD = File Descriptor?
	  # With 3 requests to the same port
	  # 1st request:
	  # `request` = "GET / HTTP/1.1\r\n"
	  # `session` #<TCPSocket:fd 10>
	  # 2nd request:
	  # `request` = "GET / HTTP/1.1\r\n"
	  # **************************************** `session` #<TCPSocket:fd 11> ***********
	  # 3rd request:
	  # `request` = "GET /favicon.ico HTTP/1.1\r\n"
	  # `session` #<TCPSocket:fd 10>
	  # 4th request:
	  # `request` = "GET /favicon.ico HTTP/1.1\r\n"
	  # **************************************** `session` #<TCPSocket:fd 11> ***********
	  session.close # If you don't close it, you can never make another request
	end
end