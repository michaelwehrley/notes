# IPSocket
# IPSocket is the super class of TCPSocket and UDPSocket.

# ===============

# TCPSocket (Transmission *Control* Protocol)
# TCPSocket represents a TCP/IP client socket.
# TCP is not just one way communication — 
# the remote system sends packets back to 
# acknowledge it is received your packets.

# UDPSocket (User Datagram [data +‎ -gram] Protocol)
# the specifications of the Internet Protocol say
# that datagrams are what pass through the network,
# UDPSocket represents a UDP/IP socket.
# When using UDP, packets are just sent to the recipient.

# =============

# `initialize': Connection refused - connect(2) 
# for "localhost" port 3000 (Errno::ECONNREFUSED)

require "socket"

# You tneed the server to be running before you can connect...
socket = TCPSocket.new("localhost", 2000)

puts TCPSocket.getaddress("localhost") # ::1
puts TCPSocket.getaddress("ip6-localhost") # 198.105.254.19
puts TCPSocket.gethostbyname("localhost")
# localhost
# 30
# ::1
# 127.0.0.1
puts TCPSocket.gethostbyname("ip6-localhost")
# ip6-localhost.tds
# 2
# 198.105.254.19
# 198.105.244.19
socket = UDPSocket.new
puts UDPSocket.getaddress("localhost") # ::1

while line = socket.gets # Read lines from socket
  puts line         	 # and print them
end

socket.close             # close socket when done