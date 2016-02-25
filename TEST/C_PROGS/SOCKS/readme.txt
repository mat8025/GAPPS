 Raw proto
	
int s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);

In such a socket, the IP header shall be provided by the kernel. 
The application has to provide the UDP header + Data. 
If the IP_HDRINCL option is set on it, then the application would need to provide the IP header too.

Raw udp sockets

Raw udp sockets are used to send manually constructed udp packets. 
The udp header can be found in RFC 768 and has a very simple structure as shown below.



0      7 8     15 16    23 24    31
+--------+--------+--------+--------+
|     Source      |   Destination   |
|      Port       |      Port       |
+--------+--------+--------+--------+
|                 |                 |
|     Length      |    Checksum     |
+--------+--------+--------+--------+
|
|          data octets ...
+---------------- ...

	User Datagram Header Format

The length is the length of the udp header + data in bytes. 
So the udp header itself is 8 byte long and data can be upto 65536 byte long. 
The checksum is calculated the same way as the checksum of a tcp header, using a pseudo header.

The code example shown here is for Linux.
 Raw socket support is not fully available in the windows socket api (winsock).
 It is there but with a lot of restrictions.

Examples shown here would construct the IP header along with the udp socket.
So its more like a raw IP packet that encapsulates UDP format data inside itself.

