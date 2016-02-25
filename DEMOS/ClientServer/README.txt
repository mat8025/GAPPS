//
//

  server1 should be launched first with port_id as an argument

   asl server1.asl 9892

   server creates socket, and binds address

   then listens and if a client arrives on same port_id
   reads messages then reverses the message and sends it out to the client


   the client is launched
   asl client.asl 127.0.0.1 9892
   or a network ip
   asl client.asl 198.168.0.1 9892
  
   the command
   ifconfig -a 
   will tell you your ip address

   client.asl creates a socket (does not bind!)
   then connects

  send a message
  "whatever"

 server outputs
 got connected 5 
 0 read  8 8


 chars >>>   whatever

client then receives the processed (reversed) message

 revetahw

  


