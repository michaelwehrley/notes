# TCPServer
# TCPServer represents a TCP/IP server socket.
require "socket"

server = TCPServer.new(2000)
loop do
  # Thread.start(server.accept) do |client|
	client = server.accept #<TCPSocket:0x007fc20d99d258>
    client.puts "Hello !"
    client.puts "Time is #{Time.now}"
    client.close # closes the connection between for the client
  # end
end
